import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_utils/cus_wave(%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B3%A2%E6%B5%AA)/mic/mic_waveform_controller.dart';

class MicWaveformWidget extends StatefulWidget {
  final MicWaveformController controller;

  const MicWaveformWidget({super.key, required this.controller});
  @override
  State<MicWaveformWidget> createState() => _MicWaveformWidgetState();
}

class _MicWaveformWidgetState extends State<MicWaveformWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      //定义动画控制的变化范围
      lowerBound: -1.0,
      upperBound: 1.0,
      duration: const Duration(seconds: 1),
    );

    final MicWaveformController(:waveHeight, :waveSize) = widget.controller;
    if (waveHeight > 0 && waveSize > 0) _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.reset();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //1.最外面半个椭圆弧线
    final cusHalfEllipsePainter = CustomPaint(
      painter: CusHalfEllipsePainter(),
      size: const Size(28, 32),  
      // size: Size.infinite,//撑满整个屏幕
    );

    return Center(
      child: Container(
        color: Colors.blue,
        child: Stack(
          alignment: Alignment.center,
          children: [
            //1.最外面半个椭圆弧线
            // CustomPaint(
            //   painter: CusHalfEllipsePainter(),
            //   size: const Size(28, 32),
            // ),
            cusHalfEllipsePainter,

            //2.整个椭圆弧框
            Positioned(
              top: 0,
              child: Container(
                width: 12, //变小需要改
                height: 20, //变小需要改
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  //设置完圆角度数后,需要设置裁切属性
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color(0xFF7744DC),
                    // color: Colors.red,
                    width: 1.5, //需要改
                  ),
                  color: Colors.white,
                ),
              ),
            ),
            //3.里面波浪
            Positioned(
              top: 0,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: ((context, child) {
                  //定义裁剪的路径
                  return ClipPath(
                    clipper: CustomHeaderClipPath(
                      //波浪变化的值
                      _animationController,
                      widget.controller,
                    ),
                    // 传入画布大小
                    child: buildContainer(context),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //波浪线容器
  Container buildContainer(BuildContext context) {
    //如果外面再套容器控件赋值大小
    return Container(
      // padding: EdgeInsets.all(1),
      //MediaQuery.of(context).size.height 当前视图的高度
      width: 12, //变小需要改
      height: 20, //变小需要改 //MediaQuery.of(context).size.height * 0.5,
      clipBehavior: Clip.antiAlias,

      decoration: BoxDecoration(
        color: const Color(0xFF7744DC),
        //设置完圆角度数后,需要设置裁切属性
        borderRadius: BorderRadius.circular(6), //变小需要改
      ),
    );
  }
}

//半个椭圆框
class CusHalfEllipsePainter extends CustomPainter {
  // final AnimationController animationController;
  // final MicWaveformController controller;

  // CusHalfEllipsePainter({
  //   required this.animationController,
  //   required this.controller,
  // }) : super(repaint: animationController);

  @override
  void paint(Canvas canvas, Size size) {
    // print("CustomPainter - $size");
    final paint = Paint()
      ..color = const Color(0xFF7744DC) //设置线条颜色
      ..strokeWidth = 2 //线条粗细
      ..strokeCap = StrokeCap.round // 设置边框拐角为圆角
      //stroke:使用轮廓线
      //fill:填充颜色
      ..style = PaintingStyle.stroke;

    // 定义椭圆的矩形边界
    //第一个参数控制左右
    //第二个参数控制高低
    //第三个参数控制宽度
    final rect = Rect.fromLTWH(
      size.width * 0.2, //第一个参数控制左右
      1, //第二个参数控制高低
      size.width * 0.6, //第三个参数控制宽度
      size.height * 0.7, //第四个参数控制高度
    );

    // 绘制半个椭圆
    canvas.drawArc(rect, 0, pi, false, paint);

    //绘制短线
    canvas.drawLine(
        Offset(size.width / 2, 25), Offset(size.width / 2, 30), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

//绘制波浪线动画
class CustomHeaderClipPath extends CustomClipper<Path> {
  // ///定义进度
  // double progress;

  // ///控制波浪高低
  // double waveHeight = 0.5;

  // ///控制波浪大小
  // double waveSize = 3;

  final AnimationController animationController;
  final MicWaveformController controller;
  //构建自定义动画传入进度
  CustomHeaderClipPath(
    // this.progress,
    // this.waveHeight,
    // this.waveSize,
    this.animationController,
    this.controller,
  );

  //定义裁剪规则
  @override
  getClip(Size size) {
    // print("CustomClipper - $size");
    //构建 path
    Path path = Path();

    //将路径的当前点移动到坐标 (0, 0)。
    path.moveTo(0, 0);
    //绘制一条直线到坐标 (0, 一半的高度)。
    path.lineTo(0, size.height * controller.waveHeight);

    //修改一下控制点
    //sin 和 cos 函数来创建波浪的起伏效果，并将 progress 变量作为波浪的参数。
    double controllerCenterx = size.width * controller.waveHeight +
        (size.width * controller.waveHeight + 1) *
            sin(animationController.value * pi);

    //30 代表波形的大小 //变小需要改
    double controllerCentery = size.height * controller.waveHeight +
        controller.waveSize * cos(animationController.value * pi);

    //构建 二阶曲线
    //使用二次贝塞尔曲线绘制波浪形路径
    path.quadraticBezierTo(
      //控制点
      controllerCenterx,
      controllerCentery,

      //结束点
      size.width,
      size.height * controller.waveHeight,
    );

    //绘制一条直线回到起点，闭合路径
    path.lineTo(size.width, 0);
    //这个路径将被用作裁剪的模板
    return path;
  }

  //是否刷新
  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
