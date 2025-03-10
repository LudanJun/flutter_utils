import 'dart:math';

import 'package:flutter/material.dart';

///自绘波浪线
class Bolangxianwidget extends StatefulWidget {
  final double amplitude;
  final double frequency;
  final double speed;

  const Bolangxianwidget({
    super.key,
    required this.amplitude,
    required this.frequency,
    required this.speed,
  });

  @override
  State<Bolangxianwidget> createState() => _BolangxianwidgetState();
}

class _BolangxianwidgetState extends State<Bolangxianwidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 1,
      ),
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.reset();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return ClipPath(
          clipper: Bolangxian(
            amplitude: widget.amplitude,
            frequency: widget.frequency,
            speed: widget.speed * _animationController.value,
            phase: _animationController.value * 2 * pi,
          ),
          child: Container(
            color: Colors.blue,
            height: 100,
          ),
        );
      },
    );
  }
}

class Bolangxian extends CustomClipper<Path> {
  final double amplitude; // 振幅
  final double frequency; // 频率
  final double speed; // 速度
  final double phase; // 相位
  Bolangxian({
    required this.amplitude,
    required this.frequency,
    required this.speed,
    this.phase = 0.0,
  });
  @override
  Path getClip(Size size) {
    // final path = Path();
    // path.moveTo(0, size.height);

    // for (double x = 0; x < size.width; x += 10) {
    //   // 使用正弦函数生成波浪形状
    //   final y = size.height *
    //       (1 - amplitude * sin(2 * pi * frequency * x / size.width + phase));
    //   path.lineTo(x, y);
    // }

    // path.lineTo(size.width, size.height);
    // return path;

    final Path path = Path();
    // 起点
    path.moveTo(0, 0);

    // 绘制波浪线
    for (double x = 0; x < size.width; x++) {
      // 波形y方向的计算公式
      double y = amplitude *
          sin(x * frequency * 2 * pi / size.width + 0.1 * pi / 180 + speed);
      path.lineTo(x, size.height / 2 - y);
    }

    // 终点
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
