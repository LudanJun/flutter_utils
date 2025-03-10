import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///自定义波浪动画
class CusWavePage extends StatefulWidget {
  const CusWavePage({super.key});

  @override
  State<CusWavePage> createState() => _CusWavePageState();
}

class _CusWavePageState extends State<CusWavePage>
    with SingleTickerProviderStateMixin {
  //设置头部背景使用到的颜色组
  List<Color> _colorList = [Color(0xFFE0647B), Color(0xFFFCDD89)];

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
      //定义动画控制的变化范围
      lowerBound: -1.0,
      upperBound: 1.0,
      vsync: this,
      //时间
      duration: Duration(milliseconds: 2000),
      //初始值
      value: 0.0,
    );
    //重复执行
    _animationController.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    //销毁
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 46, 20, 20),
      body: Center(
        child: Container(
          color: Colors.blue,
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: 100,
                child: CustomPaint(
                  painter: CusHalfEllipsePainter(),
                  size: Size(500, 300),
                ),
              ),

              // ClipPath(
              //   clipper: CusHalfEllipseClipper1(),
              //   child: Container(
              //     width: 200,
              //     height: 800,
              //     color: Colors.green,
              //   ),
              // ),
              micWidget(),

              // AnimatedBuilder(
              //   animation: _animationController,
              //   builder: ((context, child) {
              //     return ClipPath(
              //       //定义裁剪的路径
              //       clipper: CustomHeaderClipPath(_animationController.value),
              //       child: buildContainer(context),
              //     );
              //   }),
              // ),

              Positioned(
                left: 210,
                top: 400,
                child: Container(
                  width: 15,
                  height: 60,
                  color: Color(0xFF7744DC),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //构建话筒动效图标
  Widget micWidget() {
    return //1.椭圆形边框线
        Positioned(
      left: 115,
      top: 60,
      child: Container(
        width: 200,
        height: 300,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          //设置完圆角度数后,需要设置裁切属性
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: Color(0xFF7744DC),
            width: 15,
          ),
          color: Colors.white,
        ),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: ((context, child) {
            return ClipPath(
              //定义裁剪的路径
              clipper: CustomHeaderClipPath(_animationController.value),
              child: buildContainer(context),
            );
          }),
        ),
        //       Stack(
        //         children: [
        //           // // 1.1椭圆形
        //           // Container(
        //           //   width: 200,
        //           //   height: 300,
        //           //   // color: Colors.white,
        //           //   decoration: BoxDecoration(
        //           //     //设置完圆角度数后,需要设置裁切属性
        //           //     borderRadius: BorderRadius.circular(100),
        //           //     border: Border.all(
        //           //       color: Color(0xFF7744DC),
        //           //       width: 10,
        //           //     ),
        //           //   ),
        //           // ),
        // //裁剪成自定义的图形

        //         ],
        //       ),
      ),
    );
  }

  //波浪线容器
  Container buildContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      //MediaQuery.of(context).size.height 当前视图的高度
      width: 200,
      height: 300, //MediaQuery.of(context).size.height * 0.5,

      decoration: BoxDecoration(
        //设置一个渐变样式的背景
        gradient: LinearGradient(
          colors: [Color(0xFF7744DC), Color(0xFF7744DC)], //_colorList,
          //修改一下方向
          //这是开始的方向.左上角
          begin: Alignment.bottomLeft,
          //还有结束的方向
          end: Alignment.topRight,
        ),
      ),
    );
  }
}

//绘制波浪线动画
class CustomHeaderClipPath extends CustomClipper<Path> {
  //定义进度
  double progress;

  //构建自定义动画传入进度
  CustomHeaderClipPath(this.progress);

  //定义裁剪规则
  @override
  getClip(Size size) {
    print(size);
    //构建 path
    Path path = Path();

    path.moveTo(0, 0);

    path.lineTo(0, size.height * 0.5);

    //修改一下控制点
    double controllerCenterx =
        size.width * 0.2 + (size.width * 0.5 + 1) * sin(progress * pi);

    double controllerCentery = size.height * 0.5 + 50 * cos(progress * pi);

    //构建 二阶曲线
    path.quadraticBezierTo(
      //控制点
      controllerCenterx,
      controllerCentery,
      // size.width / 2, size.height * 0.8,

      //结束点
      size.width,
      size.height * 0.5,
    );

    path.lineTo(size.width, 0);
    return path;
  }

  //是否刷新
  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}

//半个椭圆形
class CusHalfEllipsePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF7744DC) //设置线条颜色
      ..strokeWidth = 15 //线条粗细
      ..strokeCap = StrokeCap.round // 设置边框拐角为圆角
      //stroke:使用轮廓线
      //fill:填充颜色
      ..style = PaintingStyle.stroke;

    // 定义椭圆的矩形边界
    final rect =
        Rect.fromLTWH(size.width / 6 + 5, 0, size.width / 2, size.height);

    // 绘制半个椭圆
    canvas.drawArc(rect, 0, pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

//半圆
class CusHalfEllipseClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    print(size);
    final path = Path()
      ..moveTo(size.width, size.height / 2) // 从右边中点开始
      ..arcToPoint(Offset(0, size.height / 2),
          radius: Radius.circular(size.width / 2), clockwise: false)
      ..close(); // 关闭路径
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
