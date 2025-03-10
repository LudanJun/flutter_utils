import 'package:flutter/material.dart';

///自定义动画
class AnimationCusPage extends StatefulWidget {
  const AnimationCusPage({super.key});

  @override
  State<AnimationCusPage> createState() => _AnimationCusPageState();
}

class _AnimationCusPageState extends State<AnimationCusPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    //根据_controller传的值通过animate来计算0.5-0.8之间的变化的值Animation<double>
    final Animation opacityAnimation =
        Tween(begin: 0.5, end: 0.8).animate(_controller);
    final Animation heightAnimation = Tween(begin: 100.0, end: 150.0)
        .chain(CurveTween(curve: Curves.bounceOut))
        .chain(CurveTween(curve: Interval(0.2, 0.8)))
        .animate(_controller);

    return Scaffold(
      appBar: AppBar(
        title: Text("自定义动画"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //1.系统自带的
            FadeTransition(
              //透明度
              opacity: _controller,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    "Hi",
                    style: TextStyle(fontSize: 72),
                  ),
                ),
              ),
            ),

            //2.自定义渐变动画
            AnimatedBuilder(
              //传入_controller数组,每次变化 就会重新叫builder一次来绘制里面的内容,每帧都会重画
              animation: _controller, //0~1 之间的值
              builder: (context, child) {
                return Opacity(
                  //1.原本写法
                  // opacity: _controller.value, //拿到具体数值 0~1改变透明度
                  //2.优化写法
                  // opacity: Tween(begin: 0.0, end: 1.0).evaluate(_controller),
                  //3.第三种写法 opacity只需要普通的double数值 所以通过.value把Animation<double>转换一下
                  opacity: opacityAnimation.value,
                  child: Container(
                    width: 100,
                    //因为是colum从上往下排列 所以动画高度是逐渐伸长
                    //1.基本写法
                    // height: 100 + 100 * _controller.value, //可以改变高度
                    //2.优化写法 evaluate:根据_controller变化求200.0-300.0之间的值
                    // height:
                    //     Tween(begin: 200.0, end: 300.0).evaluate(_controller),
                    //3.高端写法
                    height: heightAnimation.value,
                    color: Colors.red,
                    //此处child的是从外面child传进来的因为不需要重绘改变就在外面构建以此来减少性能开销
                    child: child,
                  ),
                );
              },
              child: Center(
                child: Text(
                  "Hi",
                  style: TextStyle(fontSize: 72),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
