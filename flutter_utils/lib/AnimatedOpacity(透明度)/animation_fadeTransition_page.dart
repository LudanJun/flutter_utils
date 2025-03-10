import 'package:flutter/material.dart';

class AnimationFadetransitionPage extends StatefulWidget {
  const AnimationFadetransitionPage({super.key});

  @override
  State<AnimationFadetransitionPage> createState() =>
      _AnimationFadetransitionPageState();
}

class _AnimationFadetransitionPageState
    extends State<AnimationFadetransitionPage>
    with SingleTickerProviderStateMixin {
  //1.定义AnimationController
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //配置vsync 需要 with SingleTickerProviderStateMixin
    _controller =
        //添加..repeat()重复运动 表示屏幕刷新频率和手机刷新频率同步
        AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      // lowerBound: 0.5, //从0.5开始
      // upperBound: 1, //到1结束
    );
    //监听_controller
    _controller.addListener(() {
      //_controller的值从0-1
      print(_controller.value);
      setState(() {});
    });

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    // 先注销监听器
    _controller.removeListener(() => setState(() {}));
    // _controller.removeStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     _controller.reverse();
    //   }
    //   if (status == AnimationStatus.dismissed) {
    //     _controller.forward();
    //   }
    // });
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("透明度循环变化"),
      ),
      body:
          // Center(
          //   child: FadeTransition(
          //     opacity: _controller,
          //     // duration: const Duration(seconds: 1),
          //     child: Image.asset(
          //       "assets/talking.png",
          //       fit: BoxFit.fill,
          //       width: 140,
          //       height: 190,
          //     ),
          //   ),
          // ),
          Center(
        child: AnimatedOpacity(
          opacity: _controller.value,
          duration:
              _controller.duration!, //const Duration(seconds: 2), //动画持续时间
          curve: Curves.bounceOut, //动画运行轨迹
          child: Container(
            width: 200,
            height: 200,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
