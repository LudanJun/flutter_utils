import 'package:flutter/material.dart';
import 'package:flutter_utils/ainia%E5%8A%A8%E7%94%BB/logo_animation_page.dart';
import 'package:flutter_utils/ainia%E5%8A%A8%E7%94%BB/logo_two_page.dart';

//首页动画
class AiniaAnimationPage extends StatefulWidget {
  const AiniaAnimationPage({super.key});

  @override
  State<AiniaAnimationPage> createState() => _AiniaAnimationPageState();
}

class _AiniaAnimationPageState extends State<AiniaAnimationPage>
    with TickerProviderStateMixin {
  late AnimationController _leftHeadController;
  late Animation<double> _leftHeadAnimation;

  late AnimationController _rightHeadController;
  late Animation<double> _rightHeadAnimation;

  late AnimationController _guangxiaoController;
  late Animation<double> _scaleAnimation; //缩放
  late Animation<double> _fadeAnimation; //渐变

  late AnimationController _guangxiao2Controller;
  late Animation<double> _scale2Animation; //缩放
  late AnimationController _fade2Controller;
  late Animation<double> _fade2Animation; //渐变
  late Animation<double> _fade3Animation; //渐变
  late Animation<double> _scale3Animation; //缩放

  @override
  void initState() {
    //左边头上下晃动
    _leftHeadController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _leftHeadAnimation = Tween<double>(begin: -15, end: 15).animate(
      CurvedAnimation(
        parent: _leftHeadController,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        //添加刷新
        setState(() {});
        // print(_headAnimation.value);
      });

    //右边头上下晃动
    _rightHeadController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _rightHeadAnimation = Tween<double>(begin: 10, end: -10).animate(
      CurvedAnimation(
        parent: _rightHeadController,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        //添加刷新
        setState(() {});
        // print(_headAnimation.value);
      });

    _guangxiaoController = AnimationController(
      duration: const Duration(seconds: 5),
      // lowerBound: 0.0,
      // upperBound: 1.0,
      vsync: this,
    );
    //1,放大
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _guangxiaoController,
        curve: Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    //2.渐变消失
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _guangxiaoController,
        curve: Interval(0.5, 1, curve: Curves.easeOut),
      ),
    )..addListener(() {
        setState(() {});
      });
    _guangxiaoController.repeat();

    _guangxiao2Controller = AnimationController(
      // duration: const Duration(seconds: 6),
      // lowerBound: 0.0,
      // upperBound: 1.0,
      vsync: this,
    );
    _fade2Controller = AnimationController(vsync: this);
    //1,放大
    _scale2Animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _guangxiao2Controller,
        curve: Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    //2.渐变消失
    _fade2Animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _guangxiao2Controller,
        curve: Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    )..addListener(() {
        setState(() {});
      });
    //3.缩放
    _scale3Animation = Tween<double>(begin: 1.2, end: 1.2).animate(
      CurvedAnimation(
        parent: _fade2Controller,
        curve: Interval(0.0, 1, curve: Curves.easeOut),
      ),
    );
    //3.渐变
    _fade3Animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _fade2Controller,
        curve: Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    )..addListener(() {
        setState(() {});
      });

    start();
    super.initState();
  }

  @override
  void dispose() {
    _leftHeadController.dispose();
    _rightHeadController.dispose();
    _guangxiaoController.dispose();
    super.dispose();
  }

  void start() async {
    _leftHeadController.repeat(reverse: true);
    _rightHeadController.repeat(reverse: true);
    // _guangxiaoController.repeat().then((_) {
    //   // 动画完成后，延迟1秒然后渐变消失
    //   Future.delayed(const Duration(seconds: 1), () {
    //     print('延迟一秒');
    //   });
    // });

    // _guangxiaoController.repeat();
    // await Future.delayed(Duration(milliseconds: 1000));

    //第一步先放大
    _guangxiao2Controller.duration = Duration(seconds: 3);
    _guangxiao2Controller.repeat();
    await Future.delayed(Duration(seconds: 3));
    //第二步紧跟渐变
    _guangxiao2Controller.duration = Duration(seconds: 3);
    _guangxiao2Controller.repeat();
    await Future.delayed(Duration(seconds: 3));
    // _guangxiao2Controller.reset();

    // //第一步先放大
    // _guangxiao2Controller.duration = Duration(seconds: 2);
    // _guangxiao2Controller.forward();
    // await Future.delayed(Duration(seconds: 2));
    // //第二步紧跟渐变
    // _guangxiao2Controller.duration = Duration(seconds: 2);
    // _guangxiao2Controller.forward();
    // await Future.delayed(Duration(seconds: 2));

    //第三步渐变停留
    _fade2Controller.duration = Duration(seconds: 3);
    _fade2Controller.repeat(reverse: true);
    await Future.delayed(Duration(seconds: 3));
    // _fade2Controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          "assets/loading.bg.image.png",
          fit: BoxFit.fill,
        ),
        // Positioned(
        //   left: 0,
        //   right: 0,
        //   top: 130,
        //   child: Center(
        //     child: Image.asset(
        //       "assets/logo.ainia.png",
        //       fit: BoxFit.fill,
        //     ),
        //   ),
        // ),
        // LogoAnimationPage(),
        LogoTwoPage(),
        Positioned(
          child: Container(
            child: Image.asset(
              "assets/loading.black.png",
              // fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 160,
          child: Center(
            child: Image.asset(
              "assets/loading.men.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 0,
          bottom: 80,
          child: Center(
            child: Image.asset(
              "assets/loading.men.guangxiao.png",
              fit: BoxFit.fill,
            ),
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 180,
          child: ScaleTransition(
            scale: _scaleAnimation,
            //   _guangxiaoController.drive(
            // Tween(begin: 1, end: 1.2),
            // ),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Center(
                child: Image.asset(
                  "assets/loading.guangxiao.1.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),

        // Positioned(
        //   left: 0,
        //   right: 0,
        //   bottom: 180,
        //   child: FadeTransition(
        //     opacity: _fadeAnimation, //_guangxiaoController,
        //     child: ScaleTransition(
        //       scale: _guangxiaoController.drive(
        //         Tween(begin: 1, end: 1.2),
        //       ),
        //       child: Center(
        //         child: Image.asset(
        //           "assets/guangxiao.1.png",
        //           fit: BoxFit.fill,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 180,
          child: ScaleTransition(
            scale: _scale2Animation,
            // _guangxiaoController.drive(
            //   Tween(begin: 1, end: 1.2),
            // ),
            child: FadeTransition(
              opacity: _fade2Animation,
              child: Center(
                child: Image.asset(
                  "assets/loading.guangxiao.2.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        /*
        Positioned(
          left: 0,
          right: 0,
          bottom: 180,
          child: ScaleTransition(
            scale: _scale2Animation,
            // _guangxiaoController.drive(
            //   Tween(begin: 1, end: 1.2),
            // ),
            child: FadeTransition(
              opacity: _fade2Animation,
              child: ScaleTransition(
                scale: _scale3Animation,
                child: FadeTransition(
                  opacity: _fade3Animation,
                  child: Center(
                    child: Image.asset(
                      "assets/guangxiao.2.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),*/
        // Positioned(
        //   left: 0,
        //   right: 0,
        //   bottom: 180,
        //   child: Center(
        //     child: Image.asset(
        //       "assets/guangxiao.2.png",
        //       fit: BoxFit.fill,
        //     ),
        //   ),
        // ),
        Positioned(
          left: 0,
          top: 400 - _leftHeadAnimation.value,
          right: 270,
          bottom: 400 + _leftHeadAnimation.value,
          child: Center(
            child: Image.asset(
              "assets/loading.left.dot.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          left: 200,
          right: 0,
          top: 550 - _rightHeadAnimation.value,
          bottom: 280 + _rightHeadAnimation.value,
          child: Image.asset(
            "assets/loading.right.head.png",
            width: 69,
            height: 85,
          ),
        ),
      ],
    );
  }
}
