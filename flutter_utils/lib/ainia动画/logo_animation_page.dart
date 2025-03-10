import 'package:flutter/material.dart';

class LogoAnimationPage extends StatefulWidget {
  const LogoAnimationPage({super.key});

  @override
  State<LogoAnimationPage> createState() => _LogoAnimationPageState();
}

class _LogoAnimationPageState extends State<LogoAnimationPage>
    with TickerProviderStateMixin {
  //来个动画控制器 让内容动起来
  late AnimationController _animationController;
  late AnimationController _fadeAnimationController;

  //控制第一次闪过
  late Animation<double> _go1Animation;

  //控制第二次快速闪过
  late Animation<double> _go2Animation;

  //控制第三次快速倒回
  late Animation<double> _hui3Animation;

  //控制第四次快速闪过
  late Animation<double> _go4Animation;

  //渐变闪烁1次
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      //执行时间为1秒
      // duration: Duration(milliseconds: 2000),
    );
    _fadeAnimationController = AnimationController(
      vsync: this,
    );

    // _go1Animation = Tween(begin: 0.0, end: 1.0).animate(
    //   CurvedAnimation(
    //     parent: _animationController,
    //     curve: Curves.ease, // Interval(0.0, 0.2),
    //   ),
    // );
    _fadeAnimation = Tween(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(parent: _fadeAnimationController, curve: Curves.ease),
    );
    start();
  }

  void start() async {
    //1.第一次闪过
    while (true) {
      _animationController.duration = Duration(milliseconds: 800);
      _animationController.forward();
      await Future.delayed(Duration(milliseconds: 800));
      _animationController.reset();

      //2.第二次闪过 比第一次慢
      _animationController.duration = Duration(milliseconds: 1000);
      _animationController.forward();
      await Future.delayed(Duration(milliseconds: 1000));

      //3.第三次回退比第二次慢
      _animationController.duration = Duration(milliseconds: 1200);
      _animationController.reverse();
      await Future.delayed(Duration(milliseconds: 1200));

      //4.第四次闪过比第一次快
      _animationController.duration = Duration(milliseconds: 600);
      _animationController.forward();
      await Future.delayed(Duration(milliseconds: 1200));
      _animationController.reset();

      _fadeAnimationController.duration = Duration(milliseconds: 2000);
      _fadeAnimationController.repeat(reverse: true);
      await Future.delayed(Duration(milliseconds: 2000));

      _fadeAnimationController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          top: 130,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: Image.asset(
                "assets/loading.logo.ainia.png",
                // fit: BoxFit.fill,
                width: 238,
                height: 114,
              ),
            ),
          ),

          //  Center(
          //   child: Image.asset(
          //     "assets/logo.ainia.png",
          //     // fit: BoxFit.fill,
          //     width: 238,
          //     height: 114,
          //   ),
          // ),
        ),
        Positioned(
          // left: 0,
          // top: 0,
          // // right: 0,
          // bottom: 0,
          // left: 0,
          // right: 0,
          top: 140,
          child: SlideTransition(
            position: Tween(
              begin: Offset(0.0, 0),
              end: Offset(2.5, 0),
            )
                // .chain(
                //     CurveTween(curve: Interval(0.0, 0.2, curve: Curves.ease)))
                .animate(_animationController),
            child: Image.asset(
              "assets/loading.zi.saotu.png",
              // fit: BoxFit.fill,
              width: 114,
              height: 84,
            ),
          ),
        ),
      ],
    );
    /*
    return Scaffold(
      appBar: AppBar(
        title: Text("logo动画"),
      ),
      body: Container(
        color: Colors.black,
        child: 
        
        Stack(
          children: [
            Positioned(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Center(
                  child: Image.asset(
                    "assets/logo.ainia.png",
                    // fit: BoxFit.fill,
                    width: 238,
                    height: 114,
                  ),
                ),
              ),

              //  Center(
              //   child: Image.asset(
              //     "assets/logo.ainia.png",
              //     // fit: BoxFit.fill,
              //     width: 238,
              //     height: 114,
              //   ),
              // ),
            ),
            Positioned(
              left: 0,
              top: 0,
              // right: 0,
              bottom: 0,
              child: SlideTransition(
                position: Tween(
                  begin: Offset(-1, 0),
                  end: Offset(4, 0),
                )
                    // .chain(
                    //     CurveTween(curve: Interval(0.0, 0.2, curve: Curves.ease)))
                    .animate(_animationController),
                child: Image.asset(
                  "assets/zi.saotu.png",
                  // fit: BoxFit.fill,
                  width: 114,
                  height: 84,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        //1.第一次闪过
        // while (true) {
        _animationController.duration = Duration(milliseconds: 400);
        _animationController.forward();
        await Future.delayed(Duration(milliseconds: 400));
        _animationController.reset();

        //2.第二次闪过 比第一次慢
        _animationController.duration = Duration(milliseconds: 600);
        _animationController.forward();
        await Future.delayed(Duration(milliseconds: 600));

        //3.第三次回退比第二次慢
        _animationController.duration = Duration(milliseconds: 800);
        _animationController.reverse();
        await Future.delayed(Duration(milliseconds: 800));

        //4.第四次闪过比第一次快
        _animationController.duration = Duration(milliseconds: 200);
        _animationController.forward();
        await Future.delayed(Duration(milliseconds: 800));
        _animationController.reset();

        _fadeAnimationController.duration = Duration(milliseconds: 1000);
        _fadeAnimationController.repeat(reverse: true);
        await Future.delayed(Duration(milliseconds: 1000));

        _fadeAnimationController.reset();

        // }

        /*
        _animationController.duration = Duration(milliseconds: 500);
        //从0到1 的动画
        _animationController.forward().then((_) {
          print("1111");
          //等待1秒
          Future.delayed(const Duration(milliseconds: 100), () {
            print("等待1秒");
            _animationController.reset();

            _animationController.duration = Duration(milliseconds: 300);

            //再次从0到1 的动画
            _animationController.forward().then((_) {
              print("2222");

              //等待1秒
              Future.delayed(const Duration(seconds: 1), () {
                print("等待1秒");
                _animationController.duration = Duration(milliseconds: 200);

                //从1到0的动画
                _animationController.reverse();
              });
            });
          });
        });
        */
      }),
    );
    */
  }
}
