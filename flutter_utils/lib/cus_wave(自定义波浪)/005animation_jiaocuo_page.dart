import 'package:flutter/material.dart';

///交错动画
class AnimationJiaocuoPage extends StatefulWidget {
  const AnimationJiaocuoPage({super.key});

  @override
  State<AnimationJiaocuoPage> createState() => _AnimationJiaocuoPageState();
}

class _AnimationJiaocuoPageState extends State<AnimationJiaocuoPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      // lowerBound: -1,
      // upperBound: 1,
      duration: const Duration(seconds: 2),
    )
      // ..repeat();
      ..repeat(reverse: true); //重复往返运动
    // _controller.reverse();
    //重复次数
    // _controller.repeat(reverse: true);
    // _controller.repeatFor(times: 1);
    // _controller.reverse();
    // _controller.addListener(() {

    // });
    // _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("交错动画"),
      ),
      body: Center(
        child: Column(
          children: [
            SlidingBox(
              controller: _controller,
              color: Colors.blue[300],
              curve: const Interval(0.1, 0.3),
            ),
            SlidingBox(
              controller: _controller,
              color: Colors.blue[500],
              curve: const Interval(0.2, 0.5),
            ),
            SlidingBox(
              controller: _controller,
              color: Colors.blue[700],
              curve: const Interval(0.5, 0.7),
            ),
            SlidingBox(
              controller: _controller,
              color: Colors.blue[900],
              curve: const Interval(0.7, 0.9),
            ),
            AnswerQuestionTipWidget(
              controller: _controller,
              color: Colors.amber,
              curve: const Interval(0.0, 1.0),
            ),
          ],
        ),
      ),
    );
  }
}

//封装动画
class SlidingBox extends StatelessWidget {
  //_下划线变量是私有变量
  final AnimationController controller; //传入动画控制器
  final Color? color; //传入颜色 注意可空类型 意思可以传空null
  final Curve curve; //曲线运动参数 这里传入的是运动时间
  const SlidingBox(
      {super.key,
      required this.controller,
      required this.color,
      required this.curve});

  @override
  Widget build(BuildContext context) {
    //显示移动动画
    return SlideTransition(
      position: controller.drive(
        //动画移动(1,1)相当于移动1个本身控件的大小
        Tween(
          begin: const Offset(0.0, 0.0),
          end: const Offset(1, 0.0),
        )
            //可以添加多个动画效果
            // .chain(CurveTween(curve: Curves.bounceOut))
            // .chain(CurveTween(curve: Curves.linearToEaseOut))
            //chain传入的Interval(0.7, 0.9) 代表在这个时间区间才开始动
            .chain(
          CurveTween(curve: curve),
        ),
      ),
      child: Container(
        width: 120,
        height: 60,
        color: color,
      ),
    );
  }
}

///回答问题正确错误顶部提示条
class AnswerQuestionTipWidget extends StatelessWidget {
  ///传入动画控制器
  final AnimationController controller;

  ///曲线运动参数 这里传入的是运动时间
  final Curve curve;

  ///传入颜色 注意可空类型 意思可以传空null
  final Color? color;

  const AnswerQuestionTipWidget({
    super.key,
    required this.controller,
    required this.curve,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: controller.drive(
        //动画移动(1,1)相当于移动1个本身控件的大小
        Tween(
          begin: const Offset(-1, 0.0),
          end: const Offset(0, 0.0),
        )

            ///可以添加多个动画效果
            .chain(CurveTween(curve: Curves.bounceOut))
            // .chain(CurveTween(curve: Curves.linearToEaseOut))
            //chain传入的Interval(0.7, 0.9) 代表在这个时间区间才开始动
            .chain(
              CurveTween(curve: curve),
            ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        color: color,
      ),
    );
  }
}

extension AnimExtensions on AnimationController {
  repeatFor({required int times}) async {
    for (int i = 0; i < times; i++) {
      // await forward(from: 0);
      // await repeat();
    }
    return;
  }
}
