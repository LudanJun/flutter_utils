import 'dart:math';

import 'package:flutter/material.dart';

class AnimationBingtuPage extends StatefulWidget {
  const AnimationBingtuPage({super.key});

  @override
  State<AnimationBingtuPage> createState() => _AnimationBingtuPageState();
}

//定义一个全局的内如主颜色
Color mainColor = Color(0xFFCADCED);

class _AnimationBingtuPageState extends State<AnimationBingtuPage>
    with SingleTickerProviderStateMixin {
  //来个动画控制器 让内容动起来
  late AnimationController _animationController;

  //控制背景太高使用的
  late Animation<double> _bgAnimation;

  //控制饼图使用的
  late Animation<double> _progressAnimation;

  //控制数字使用的
  late Animation<double> _numberAnimation;

  @override
  void initState() {
    super.initState();

    //初始化一下动画控制器
    _animationController = AnimationController(
      vsync: this,
      //执行时间为1秒
      duration: Duration(milliseconds: 2000),
    );

    _bgAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      //执行时间的区间
      //curve 动画效果 bounceOut 回弹效果
      curve: Interval(0.0, 0.5, curve: Curves.bounceOut),
    ));

    _progressAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      //执行时间的区间
      curve: Interval(0.4, 0.8, curve: Curves.bounceOut),
    ));

    _numberAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      //执行时间的区间
      curve: Interval(0.7, 1.0, curve: Curves.bounceOut),
    ));

    //添加一个监听 刷新页面
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          //高度
          height: 260,
          width: MediaQuery.of(context).size.width,
          //设置一下背景
          color: mainColor,
          //封装一个方法构建左右排列的
          child: buildRow(),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        //按钮点击开启动画
        _animationController.reset();
        _animationController.forward();
      }),
    );
  }

  //定义数据模型
  final List _list = [
    {
      "title": "生活费",
      "number": 200,
      "color": Colors.blue,
    },
    {
      "title": "交通费",
      "number": 100,
      "color": Colors.green,
    },
    {
      "title": "贷款费",
      "number": 300,
      "color": Colors.red,
    },
    {
      "title": "游玩费",
      "number": 200,
      "color": Colors.amber,
    },
    {
      "title": "电话费",
      "number": 400,
      "color": Colors.deepOrangeAccent,
    },
  ];

  Widget buildRow() {
    return Row(
      children: [
        //权重适配 占用宽度5:6
        Expanded(
          flex: 5,
          //左边是一个竖直方向排列的线性布局
          child: buildLeftColumn(),
        ),
        //右边是饼图区域
        Expanded(
          flex: 6,
          child: Stack(
            //子widget 居中
            alignment: Alignment.center,
            children: [
              //第一层
              Container(
                padding: EdgeInsets.all(22),
                //来个边框装饰
                decoration: BoxDecoration(
                  //外圆的背景颜色
                  color: mainColor,
                  shape: BoxShape.circle,
                  //来个阴影
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: -8 * _bgAnimation.value,
                      offset: Offset(
                          -5 * _bgAnimation.value, -5 * _bgAnimation.value),
                      blurRadius: 30 * _bgAnimation.value,
                    ),
                    BoxShadow(
                      //模糊颜色
                      color: Colors.blue[300]!.withOpacity(0.3),
                      //模糊半径
                      spreadRadius: 2 * _bgAnimation.value,
                      //阴影偏移量
                      offset: Offset(
                          5 * _bgAnimation.value, 5 * _bgAnimation.value),
                      //模糊度
                      blurRadius: 20 * _bgAnimation.value,
                    ),
                  ],
                ),
                //开始绘制神操作
                child: CustomPaint(
                  //设置画布大小
                  size: Size(200, 200),
                  painter: CustomShapPainter(_list, _progressAnimation.value),
                ),
              ),
              //第二层
              Container(
                //层叠不能有高度
                width: 100,
                decoration: BoxDecoration(
                  color: mainColor,
                  shape: BoxShape.circle,
                  //添加阴影
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 3 * _numberAnimation.value,
                      blurRadius: 5 * _numberAnimation.value,
                      offset: Offset(5 * _numberAnimation.value,
                          5 * _numberAnimation.value),
                      color: Colors.black54,
                    ),
                  ],
                ),
                // height: 100,
                child: Center(
                  child: Text(
                    "¥ 100",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column buildLeftColumn() {
    return Column(
      //设置包裹子Widget
      mainAxisSize: MainAxisSize.min,
      //图例排列
      children: _list.map((data) {
        return Container(
          //设置左右上下边距
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Row(
            children: [
              Container(
                //小圆点和文字间距
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: data["color"],
                  //设置成圆形
                  shape: BoxShape.circle,
                ),
                width: 10,
                height: 10,
              ),
              Text(
                data["title"],
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class CustomShapPainter extends CustomPainter {
  //数据内容
  List list;
  //接收动画数值 开始让饼图动起来
  double progress;
  CustomShapPainter(this.list, this.progress);
  //来个画笔
  //isAntiAlias:是否对绘制在画布上的线条和图像应用抗锯齿功能 。
  Paint _paint = Paint()..isAntiAlias = true;

  ///绘制内容
  @override
  void paint(Canvas canvas, Size size) {
    //中心
    Offset center = Offset(size.width / 2, size.height / 2);
    //半径 取宽高一半 最小值
    double radius = min(size.width / 2, size.height / 2);

    //开始绘制的弧度
    double startRadian = -pi / 2;

    //总金额
    double total = 0.0;
    for (var element in list) {
      total += element["number"];
    }

    //开始绘制
    for (var i = 0; i < list.length; i++) {
      //当前要绘制的选项
      var item = list[i];

      //计算所占的比例
      double flag = item["number"] / total;

      //计算弧度 给弧度传值
      double sweepRadin = flag * 2 * pi * progress;

      //开始绘制弧
      //设置一下画笔的颜色
      _paint.color = item["color"];
      canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
        startRadian,
        sweepRadin,
        true,
        _paint,
      );

      //累加下次开始绘制的角度
      startRadian += sweepRadin;
    }
  }

  /// 返回刷新
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
