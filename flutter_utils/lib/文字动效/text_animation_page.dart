import 'package:flutter/material.dart';

class TextAnimationPage extends StatefulWidget {
  const TextAnimationPage({super.key});

  @override
  State<TextAnimationPage> createState() => _TextAnimationPageState();
}

class _TextAnimationPageState extends State<TextAnimationPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller2;

  // late Animation _animation;
  @override
  void initState() {
    super.initState();
    /*文字闪烁
    _controller = AnimationController(
        duration: Duration(milliseconds: 4000), vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.repeat(reverse: true);
   */
    _controller = AnimationController(vsync: this);
    _controller2 = AnimationController(vsync: this);

    if (mounted) {
      start();
    }
  }

  //这样写不行
  void start() async {
    //1快速走一下
    _controller.duration = Duration(seconds: 1);
    _controller.forward();
    //等待300毫秒执行下面操作
    await Future.delayed(Duration(milliseconds: 300));

    //2慢速走一下
    _controller.duration = Duration(seconds: 2);
    _controller.forward();
    //等待300毫秒执行下面操作
    await Future.delayed(Duration(milliseconds: 300));

    //3回去
    _controller.duration = Duration(seconds: 1);
    _controller.reverse();
    //等待300毫秒执行下面操作
    await Future.delayed(Duration(milliseconds: 300));

    //4快速走一下
    _controller.duration = Duration(seconds: 500);
    _controller.forward();
    //等待300毫秒执行下面操作
    await Future.delayed(Duration(milliseconds: 300));


    _controller2.duration = Duration(milliseconds: 1000);
    _controller2.repeat(reverse: true);
    //等待7秒再去执行
    await Future.delayed(Duration(seconds: 3));
    // //运行7秒后重置
    // _controller2.reset();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //获取屏幕大小,
    Size size = MediaQuery.of(context).size;
    //创建一个渐变效果,这里是用的线性渐变,也可以替换成RadialGradient或者SweepGradient.
    //RadialGradient: 圆形渐变
    //SweepGradient:扫掠渐变
    Gradient gradient =
        SweepGradient(colors: [Colors.grey, Colors.blue, Colors.grey]);
    //根据gradient创建shader,使用的createShader方法.createShader方法其实有两个参数,
    //其中rect是必须要传递的,因为它指定了范围,而第二个参数textDirection是关于文字方向的
    Shader shader =
        gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    return Scaffold(
      appBar: AppBar(
        title: Text("文字动效"),
      ),
      body: Column(
        children: [
          // Center(
          //   child:

          //  Text(
          //   '文字渐变效果',
          //   style: TextStyle(
          //     fontSize: 36.0,
          //     foreground: Paint()..shader = shader,
          //   ),
          // ),

          //       AnimatedBuilder(
          //     animation: _animation,
          //     builder: (context, child) {
          //       double value = _animation.value;
          //       Gradient gradient = LinearGradient(
          //         colors: [Colors.grey, Colors.blue, Colors.grey],
          //         stops: [value - 0.2, value, value + 0.2],
          //       );
          //       Shader shader = gradient.createShader(
          //         Rect.fromLTWH(0, 0, size.width, size.height),
          //       );
          //       return Text(
          //         '文字渐变效果',
          //         style: TextStyle(
          //           fontSize: 36.0,
          //           foreground: Paint()..shader = shader,
          //         ),
          //       );
          //     },
          //   ),
          // ),

          //渐变动画
          FadeTransition(
            //透明度 只能传0~1之前
            opacity: Tween(begin: 1.0, end: 0.5)
                .animate(_controller2), //实际上传了一个最低值lowerBound和最高值upperBound
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                double value = _controller.value;
                Gradient gradient = LinearGradient(
                  colors: [Colors.grey, Colors.blue, Colors.grey],
                  stops: [value, value + 0.2, value],
                );
                Shader shader = gradient.createShader(
                  Rect.fromLTWH(0, 0, size.width, size.height),
                );
                return Text(
                  '文字渐变效果',
                  style: TextStyle(
                    fontSize: 36.0,
                    foreground: Paint()..shader = shader,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
