import 'dart:ffi';

import 'package:flutter/material.dart';

///显示动画
class AnimationXianshiPage extends StatefulWidget {
  const AnimationXianshiPage({super.key});

  @override
  State<AnimationXianshiPage> createState() => _AnimationXianshiPageState();
}

/**
 * SingleTickerProviderStateMixin
 * Ticker:指每次屏幕要刷新的时候,就会产生一个ticker 60帧屏幕要刷新60下
 */
class _AnimationXianshiPageState extends State<AnimationXianshiPage>
    with SingleTickerProviderStateMixin {
  //动画控制器
  late AnimationController _controller;

  bool _loading = false; //是否加载
  @override
  void initState() {
    super.initState();
    //要在这里初始化
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      lowerBound: 0.0, //下限 相当于在1秒钟转了2圈 把3-5之前给填满了
      upperBound: 1.0, //上限
      //垂直同步刷新 根据手机刷新率来决定
      vsync: this,
    );
    //..repeat(); //打..可以回传本身 简便写法
    //如果想一加载就运行动画
    // _controller.repeat();

    //监听控制器回传的值
    _controller.addListener(() {
      print("${_controller.value}");
    });
  }

  @override
  void dispose() {
        _controller.removeListener(() => setState(() {}));
    _controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("显示动画"),
      ),
      body: Column(
        children: [
          //RotationTransition旋转过度东海控件
          RotationTransition(
            //_controller自己就是 Animation<double>
            //turns 转圈 需要动画形式的Animation<double>
            turns: _controller, //[相当于从3..5之间一系列的数字]
            child: Container(
              width: 100,
              height: 100,
              color: Colors.blue,
            ),
          ),
          //渐变动画
          FadeTransition(
            //透明度 只能传0~1之前
            opacity: _controller, //实际上传了一个最低值lowerBound和最高值upperBound
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          ),
          //缩放动画
          ScaleTransition(
            // scale: _controller, //可以传0~无穷大小
            //如果想控制变量可以使用drive来驱动补间Tween属性
            scale: _controller.drive(Tween(begin: 0, end: 2)),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.orange,
            ),
          ),

          SlideTransition(
            //第一种写法
            // position: _controller.drive(
            //   Tween(
            //     begin: Offset(0, 0),
            //     end: Offset(1, 0), //动画移动(1,1)相当于移动1个本身控件的大小
            //   ),
            // ),
            //第二种写法
            position: Tween(
                    begin: Offset(0, 0),
                    end: Offset(1, 0) //动画移动(1,1)相当于移动1个本身控件的大小
                    )

                ///可以叠加动画 通过曲线改变特征
                .chain(CurveTween(curve: Curves.bounceInOut))
                //Interval取值区间意思是从0-0.5一半的时候完成动画剩余时间不动
                //如果是Interval(0.8, 1.0) 代表0-0.8时间不动 0.8-1之间把动画完成
                .chain(CurveTween(curve: Interval(0.8, 1)))
                .animate(_controller),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.green,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_loading) {
            //reset()重置
            _controller.reset();
            //stop()停止
            // _controller.stop();
          } else {
            //repeat:重复转
            // _controller.repeat();
            //forward:向前转动一次
            // _controller.forward();
            //这个动画是从0~1~0
            _controller.repeat(reverse: true);
          }
          _loading = !_loading;
        },
        tooltip: 'ADD',
        child: Icon(Icons.add),
      ),
    );
  }
}



