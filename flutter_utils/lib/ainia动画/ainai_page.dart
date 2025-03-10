import 'package:flutter/material.dart';
import 'package:flutter_utils/ainia%E5%8A%A8%E7%94%BB/logo_two_page.dart';

class AinaiPage extends StatefulWidget {
  const AinaiPage({super.key});

  @override
  State<AinaiPage> createState() => _AinaiPageState();
}

class _AinaiPageState extends State<AinaiPage> with TickerProviderStateMixin {
  //左边头
  late AnimationController _leftHeadController;
  late Animation<double> _leftHeadAnimation;

  //右边头
  late AnimationController _rightHeadController;
  late Animation<double> _rightHeadAnimation;

  //光效1
  late AnimationController _gxOneController;
  late Animation<double> _gxOneScaleAnimation; //缩放
  late Animation<double> _gxOneFadeAnimation; //渐变
  //光效2
  late AnimationController _gxTwoController;
  late Animation<double> _gxTwoScaleAnimation; //缩放
  late Animation<double> _gxTwoFadeAnimation; //渐变

  @override
  void initState() {
    super.initState();
    /******************* 左边头 ******************* */
    //左边头上下晃动
    _leftHeadController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
    _leftHeadAnimation = Tween<double>(begin: -15, end: 15).animate(
      CurvedAnimation(
        parent: _leftHeadController,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        //添加刷新
        setState(() {});
      });
    // 启动左边头动画
    _leftHeadController.repeat(reverse: true);

    /******************* 右边头 ******************* */
    //右边头上下晃动
    _rightHeadController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
    _rightHeadAnimation = Tween<double>(begin: 10, end: -10).animate(
      CurvedAnimation(
        parent: _rightHeadController,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        //添加刷新
        setState(() {});
      });
    // 启动右边头动画
    _rightHeadController.repeat(reverse: true);

    /******************* 光效1 ******************* */
    _gxOneController = AnimationController(
      duration: const Duration(milliseconds: 1300),
      vsync: this,
    );
    //1,放大
    _gxOneScaleAnimation = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(
        parent: _gxOneController,
        //在时间的0-0.5之间 放大
        curve: const Interval(0.0, 0.8, curve: Curves.ease),
      ),
    );

    //2.渐变消失
    _gxOneFadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _gxOneController,
        //在时间的0.5-1之间消失
        curve: const Interval(0.6, 1, curve: Curves.ease),
      ),
    )..addListener(() {
        setState(() {});
      });

    /******************* 光效2 ******************* */
    _gxTwoController = AnimationController(
      duration: const Duration(milliseconds: 1300),
      vsync: this,
    );
    //1,放大
    _gxTwoScaleAnimation = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(
        parent: _gxTwoController,
        //在时间的0-0.5之间 放大
        curve: const Interval(0.0, 0.8, curve: Curves.ease),
      ),
    );
    //2.渐变消失
    _gxTwoFadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _gxTwoController,
        //在时间的0.5-1之间消失
        curve: const Interval(0.6, 1, curve: Curves.ease),
      ),
    )..addListener(() {
        setState(() {});
      });
    //启动光效动画
    start();
  }

  void start() async {
    _gxOneController.repeat();
    //等500毫秒再启动第二个光效
    await Future.delayed(const Duration(milliseconds: 400));
    _gxTwoController.repeat();
  }

  @override
  void dispose() {
    _leftHeadController.dispose();
    _rightHeadController.dispose();
    _gxOneController.dispose();
    _gxTwoController.dispose();
    super.dispose();
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
        LogoTwoPage(),
        Positioned(
          child: SizedBox(
            child: Image.asset(
              "assets/loading.black.png",
            ),
          ),
        ),
        Positioned(
          bottom: 175,
          child: SizedBox(
            child: Image.asset(
              "assets/loading.men.png",
              width: 258,
              height: 370,
            ),
          ),
        ),
        Positioned(
          left: 20,
          bottom: 75,
          child: SizedBox(
            child: Image.asset(
              "assets/loading.men.guangxiao.png",
              fit: BoxFit.fill,
              width: 421,
              height: 148,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 185,
          child: ScaleTransition(
            scale: _gxOneScaleAnimation,
            child: FadeTransition(
              opacity: _gxOneFadeAnimation,
              child: SizedBox(
                child: Image.asset(
                  "assets/loading.guangxiao.1.png",
                  width: 321,
                  height: 370,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 185,
          child: ScaleTransition(
            scale: _gxTwoScaleAnimation,
            child: FadeTransition(
              opacity: _gxTwoFadeAnimation,
              child: SizedBox(
                child: Image.asset(
                  "assets/loading.guangxiao.2.png",
                  // fit: BoxFit.fill,
                  width: 333,
                  height: 374,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 400 - _leftHeadAnimation.value,
          right: 270,
          bottom: 400 + _leftHeadAnimation.value,
          child: Image.asset(
            "assets/loading.left.dot.png",
            // fit: BoxFit.fill,
            width: 108,
            height: 134,
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
