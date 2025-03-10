import 'dart:math';

import 'package:flutter/material.dart';

//操作底层 绘制
class AnimationCustomPainterPage extends StatefulWidget {
  const AnimationCustomPainterPage({super.key});

  @override
  State<AnimationCustomPainterPage> createState() =>
      _AnimationCustomPainterPageState();
}

class _AnimationCustomPainterPageState extends State<AnimationCustomPainterPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  //创建100个雪花
  final List<Snowflake> _snowflakes = List.generate(
    500,
    (index) => Snowflake(),
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("操作底层的动画"),
      ),
      body: Center(
        child: Container(
          /*
BoxConstraints.expand() 创建了一个特殊的 BoxConstraints 对象，
它指示一个 Flutter 组件（widget）应该尽可能大地扩展以填充其父级分配给它的空间。
这个约束没有固定的最小或最大尺寸，它告诉布局算法，组件想要扩展到其父级容器的边界。
这通常用于那些需要充满可用空间的组件，例如填充整个屏幕的背景或在网格或列表中的一个
          */
          // constraints: BoxConstraints.expand(),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.lightBlue,
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              //渐变的位置
              //stops 0-1之间
              stops: [0.0, 0.7, 0.95],
            ),
          ),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              //在这里让雪花动起来
              for (var snow in _snowflakes) {
                snow.fall();
              }

              //CustomPaint 系统控件名
              return CustomPaint(
                painter: MyPainter(_snowflakes),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}

///自定义绘画
class MyPainter extends CustomPainter {
  //获取传的雪花
  List<Snowflake> snowflake;
  //添加构造函数
  MyPainter(this.snowflake);

  ///具体绘画的实现
  /// Canvas :可以画点 线 长方形  等等..
  /// Size:画布的大小
  @override
  void paint(Canvas canvas, Size size) {
    // print(size);
    //1.画个圆形
    //参数1c:在哪个位置显示
    //radius:半径大小
    //paint:刷子
    final whitePaint = Paint()..color = Colors.white;
    canvas.drawCircle(size.center(Offset(0, 110)), 60.0, whitePaint);

    //2.画椭圆形
    canvas.drawOval(
        Rect.fromCenter(
          center: size.center(Offset(0, 280)),
          width: 200,
          height: 250,
        ),
        whitePaint);

    //1.创建雪花
    //2.想让动起来 需要在控件外面包裹一个 AnimatedBuilder
    // final snowflake = Snowflake();
    for (var snowflake in snowflake) {
      canvas.drawCircle(
          Offset(snowflake.x, snowflake.y), snowflake.radius, whitePaint);
    }
  }

  /// 该不该重画
  ///上一帧的CustomPainter传过来 对比需不需要重画
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    ///永远重画
    return true;
  }
}

//定义雪花
class Snowflake {
  //雪花x轴随机
  // Random().nextDouble() 0-1之间 然后*屏幕宽度
  double x = Random().nextDouble() * 420;
  double y = Random().nextDouble() * 800;
  //定义雪花半径 2- 5之间
  double radius = Random().nextDouble() * 3 + 2;
  //定义雪花速度 2- 6之间
  double speed = Random().nextDouble() * 4 + 2;

  //落下函数
  fall() {
    y += speed;
    if (y > 800) {
      //让雪花重新开始
      y = 0;
      //重新随机参数
      // Random().nextDouble() 0-1之间 然后*屏幕宽度
      x = Random().nextDouble() * 420;
      //定义雪花半径 2- 5之间
      radius = Random().nextDouble() * 3 + 2;
      //定义雪花速度 2- 6之间
      speed = Random().nextDouble() * 4 + 2;
    }
  }
}
