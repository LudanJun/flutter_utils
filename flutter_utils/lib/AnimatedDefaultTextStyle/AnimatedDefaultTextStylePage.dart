import 'package:flutter/material.dart';

class Animateddefaulttextstylepage extends StatefulWidget {
  const Animateddefaulttextstylepage({super.key});

  @override
  State<Animateddefaulttextstylepage> createState() =>
      _AnimateddefaulttextstylepageState();
}

class _AnimateddefaulttextstylepageState
    extends State<Animateddefaulttextstylepage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    //TweenSequence中定义开始和结束状态
    animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 1)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 10,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1, end: 0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 10,
      ),
    ]).animate(controller);
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //使用AnimatedDefaultTextStyle来更新省略号的宽度，从而实现动态显示的效果。
    return AnimatedDefaultTextStyle(
      style: TextStyle(
        fontSize: 50,
        color: Colors.blue,
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('.'),
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Container(
                width: animation.value * 20,
              );
            },
          ),
          Text('.'),
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Container(
                width: animation.value * 20,
              );
            },
          ),
          Text('.'),
        ],
      ),
    );
  }
}
