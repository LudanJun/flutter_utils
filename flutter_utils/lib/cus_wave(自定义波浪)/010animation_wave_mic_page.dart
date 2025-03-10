import 'dart:math';

import 'package:flutter/material.dart';

///自定义绘制麦克风
class AnimationWaveMicPage extends StatefulWidget {
  ///持续时间
  int durationTime = 800;

  ///整体颜色
  Color color = Color(0xFF7744DC);

  // ///控制波浪高低
  // double waveHeight;

  // ///控制波浪大小
  // double waveSize;

  AnimationWaveMicPage({
    super.key,
    required this.durationTime,
    required this.color,
    // required this.waveHeight,
    // required this.waveSize,
  });

  @override
  State<AnimationWaveMicPage> createState() => _AnimationWaveMicPageState();
}

class _AnimationWaveMicPageState extends State<AnimationWaveMicPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  /// 控制波浪高低
  double waveHeight = 0.5;

  ///控制波浪大小
  double waveSize = 3;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      //定义动画控制的变化范围
      lowerBound: -1.0,
      upperBound: 1.0,
      vsync: this,
      //时间
      duration: Duration(milliseconds: widget.durationTime),
      //初始值
      value: 0.0,
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.reset();
    //销毁
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        // Center(
        //   child: Container(
        //     // width: 56,
        //     // height: 21,
        //     color: Colors.blue,
        //     child:

        Center(
      child: Container(
        // width: 56,
        // height: double.infinity,
        color: Colors.blue,

        child: Stack(
          alignment: Alignment.center,
          children: [
            //1.最外面半个椭圆弧

            CustomPaint(
              painter: CusHalfEllipsePainter(),
              size: const Size(28, 32),
            ),
            //2.整个椭圆弧
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
                    color: widget.color,
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
                      _animationController.value,
                      //波浪高低
                      waveHeight,
                      //波浪大小
                      waveSize,
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
    //   ),
    // );
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
        // color: Colors.orange,
        //设置一个渐变样式的背景
        gradient: LinearGradient(
          colors: [widget.color, widget.color], //_colorList,
          //修改一下方向
          //这是开始的方向.左上角
          begin: Alignment.bottomLeft,
          //还有结束的方向
          end: Alignment.topRight,
        ),
        //设置完圆角度数后,需要设置裁切属性
        borderRadius: BorderRadius.circular(6), //变小需要改
      ),
    );
  }
}

//半个椭圆框
class CusHalfEllipsePainter extends CustomPainter {
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
  ///定义进度
  double progress;

  ///控制波浪高低
  double waveHeight = 0.5;

  ///控制波浪大小
  double waveSize = 3;

  //构建自定义动画传入进度
  CustomHeaderClipPath(
    this.progress,
    this.waveHeight,
    this.waveSize,
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
    path.lineTo(0, size.height * waveHeight);

    //修改一下控制点
    //sin 和 cos 函数来创建波浪的起伏效果，并将 progress 变量作为波浪的参数。
    double controllerCenterx = size.width * waveHeight +
        (size.width * waveHeight + 1) * sin(progress * pi);

    //30 代表波形的大小 //变小需要改
    double controllerCentery =
        size.height * waveHeight + waveSize * cos(progress * pi);

    //构建 二阶曲线
    //使用二次贝塞尔曲线绘制波浪形路径
    path.quadraticBezierTo(
      //控制点
      controllerCenterx,
      controllerCentery,

      //结束点
      size.width,
      size.height * waveHeight,
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
