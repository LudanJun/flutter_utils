import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

//动画原理
class AnimationYuanliPage extends StatefulWidget {
  const AnimationYuanliPage({super.key});

  @override
  State<AnimationYuanliPage> createState() => _AnimationYuanliPageState();
}

class _AnimationYuanliPageState extends State<AnimationYuanliPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Ticker _ticker = Ticker((elapsed) {
    //   print("Tick: $elapsed");
    // });

    // _ticker.start();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("动画原理"),
      ),
      body: Center(
        child: Column(
          children: [
            CustomPaint(
              painter: HalfEllipsePainter(),
              size: Size(400, 300),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}

class HalfEllipsePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF7744DC)
      ..strokeWidth = 10
      //stroke:使用轮廓线
      //fill:填充颜色
      ..style = PaintingStyle.stroke;

    // 定义椭圆的矩形边界
    final rect = Rect.fromLTWH(0, 0, size.width / 2, size.height);

    // 绘制半个椭圆
    canvas.drawArc(rect, 0, pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
