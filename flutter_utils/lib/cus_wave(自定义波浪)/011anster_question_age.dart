import 'dart:ui';

import 'package:flutter/material.dart';

class AnsterQuestionPage extends StatefulWidget {
  // final int beginTime;

  ///文字颜色
  final Color? textColor;

  ///背景颜色
  final Color? bgColor;
  const AnsterQuestionPage({
    super.key,
    // required this.beginTime,
    this.textColor = Colors.white,
    this.bgColor = Colors.green,
  });

  @override
  State<AnsterQuestionPage> createState() => _AnsterQuestionPageState();
}

class _AnsterQuestionPageState extends State<AnsterQuestionPage>
    with TickerProviderStateMixin {
  //定义动画控制器
  late AnimationController _quController;
  //控制开始弹出的时候再显示控件 不然返回的时候会有一个长条控件再屏幕外面显示
  bool isXianshi = false;
  @override
  void initState() {
    super.initState();
    //为什么要放在initState()里
    //因为控件还没创建出来 this是不能被访问的
    _quController = AnimationController(
      vsync: this,
    );
    // _huiController = AnimationController(
    //   vsync: this,
    // );
    start();
  }

  void start() async {
    _quController.addStatusListener((status) {
      // 根据动画状态执行操作
      if (status == AnimationStatus.completed) {
        print('动画完成completed');
        // _controller.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        print('动画反向完成dismissed');
        // _controller.forward();
        setState(() {
          isXianshi = false;
        });
      }
      if (status == AnimationStatus.forward) {
        print('动画forward');
        // _controller.forward();
      }
      if (status == AnimationStatus.reverse) {
        print('动画reverse');
        // _controller.forward();
      }
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isXianshi = true;
    });

    _quController.duration = Duration(milliseconds: 600);
    _quController.forward();

    //等待4秒执行下面操作
    await Future.delayed(Duration(seconds: 2));

    _quController.duration = Duration(milliseconds: 600);
    _quController.reverse();
  }

  @override
  void dispose() {
    // isXianshi = false;
    //销毁
    _quController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("回调问题弹出动画"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SlideTransition(
              position: _quController.drive(
                //动画移动(1,1)相当于移动1个本身控件的大小
                Tween(
                  begin: const Offset(-1, 0.0),
                  end: const Offset(0, 0.0),
                )

                    ///可以添加多个动画效果
                    // .chain(CurveTween(curve: Curves.bounceOut))
                    // .chain(CurveTween(curve: Curves.linearToEaseOut))
                    //chain传入的Interval(0.7, 0.9) 代表在这个时间区间才开始动
                    .chain(
                  CurveTween(curve: const Interval(0.0, 1.0)),
                ),
              ),
              child: Visibility(
                visible: isXianshi,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  color: Colors.green,
                  child: Text("√ Correct,Congratulations!"),
                ),
              ),
            ),
          ),
          //双层阴影背景图

          SizedBox(
            height: 20,
          ),

          Container(
            padding: EdgeInsets.all(16),
            color: Colors.amber,
            // width: 200,
            // height: 100,

            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      offset: const Offset(-10, 10),
                      blurRadius: 14,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: const Color(0xFF959595).withOpacity(0.1),
                      offset: const Offset(10, -10),
                      blurRadius: 14,
                      spreadRadius: 0,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 42.2, sigmaY: 42.2),
                    child: Text(
                      " houjunfeng ",
                      textAlign: TextAlign.left,
                      style: textTheme.headlineSmall?.copyWith(
                        color: colorScheme.surface,
                        fontFamily: "Jua",
                        fontWeight: FontWeight.w400,
                        shadows: [
                          Shadow(
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
