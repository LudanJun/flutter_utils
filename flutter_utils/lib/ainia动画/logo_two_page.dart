import 'package:flutter/material.dart';

class LogoTwoPage extends StatefulWidget {
  const LogoTwoPage({super.key});

  @override
  State<LogoTwoPage> createState() => _LogoTwoPageState();
}

class _LogoTwoPageState extends State<LogoTwoPage>
    with TickerProviderStateMixin {
  //来个动画控制器 让内容动起来
  late AnimationController _animationController;
  late AnimationController _fadeAnimationController;
  //渐变闪烁1次
  late Animation<double> _fadeAnimation;
  // late Animation<double> _baseAnimation;

  @override
  void initState() {
    super.initState();
    // _animationController = AnimationController(
    //   vsync: this,
    //   //执行时间为1秒
    //   // duration: Duration(milliseconds: 2000),
    // );
    _fadeAnimationController = AnimationController(
      vsync: this,
    );

    // _go1Animation = Tween(begin: 0.0, end: 1.0).animate(
    //   CurvedAnimation(
    //     parent: _animationController,
    //     curve: Curves.ease, // Interval(0.0, 0.2),
    //   ),
    // );
    _fadeAnimation = Tween(begin: 1.0, end: 0.6).animate(
      CurvedAnimation(parent: _fadeAnimationController, curve: Curves.ease),
    );
    // ..addListener(() {
    //     print(_fadeAnimation.value);
    //   });

    // start();
    _fadeAnimationController.duration = const Duration(milliseconds: 2000);
    _fadeAnimationController.repeat(reverse: true);
  }

  void start() async {
    while (true) {
      /*
      // //1.第一次闪过
      _animationController.duration = Duration(milliseconds: 1000);
      _animationController.forward();
      await Future.delayed(Duration(milliseconds: 1000));
      _animationController.reset();

      //2.第二次闪过 比第一次慢
      _animationController.duration = Duration(milliseconds: 500);
      _animationController.forward();
      await Future.delayed(Duration(milliseconds: 500));

      //3.第三次回退比第二次慢
      _animationController.duration = Duration(milliseconds: 500);
      _animationController.reverse();
      await Future.delayed(Duration(milliseconds: 500));

      //4.第四次闪过比第一次快
      _animationController.duration = Duration(milliseconds: 1000);
      _animationController.forward();
      await Future.delayed(Duration(milliseconds: 1000));
      _animationController.reset();
      */
      /*
  顶部 logo 闪烁为4 段一个循环 ←
透明度(60-100)1s←
透明度(80-100)0.5s←
透明度(80-100)0.5s ↔
透明度(60-100)1s←
下
蒙层扫光三次 0.5s -次 ↔
第-二次间 0.2s←
  */
      _fadeAnimationController.duration = const Duration(milliseconds: 2000);
      _fadeAnimationController.repeat(reverse: true);
      // await Future.delayed(const Duration(milliseconds: 2000));

      _fadeAnimationController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 130,
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: 238,
        height: 114,
        // color: Colors.amber,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1),
        ),
        child: Stack(
          children: [
            Positioned(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Center(
                  child: Image.asset(
                    "assets/loading.logo.ainia.png",
                    width: 238,
                    height: 114,
                  ),
                ),
              ),
            ),
            // Positioned(
            //   bottom: 20,
            //   child: SlideTransition(
            //     position: Tween(
            //       begin:const Offset(-1, 0),
            //       end:const Offset(2, 0),
            //     ).animate(_animationController),
            //     child: Image.asset(
            //       "assets/loading.zi.saotu.png",
            //       width: 114,
            //       height: 84,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
