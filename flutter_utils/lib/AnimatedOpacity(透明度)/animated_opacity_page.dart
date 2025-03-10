import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
/*
class AnimatedOpacityPage extends StatefulWidget {
  const AnimatedOpacityPage({super.key});

  @override
  State<AnimatedOpacityPage> createState() => _AnimatedOpacityPageState();
}

class _AnimatedOpacityPageState extends State<AnimatedOpacityPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  // late Timer _timer;

  //Listener：用于动画的监听，根据回调，获取动画的当前值，进行渲染。
  @override
  void initState() {
    super.initState();
    if (mounted) {
      //它负责驱动动画的生命周期。
      _controller = AnimationController(
        //vsync: this：提供了一个 TickerProvider，确保 AnimationController 的生命周期与 State 对象的生命周期一致。
        vsync: this,
        //设置了动画的持续时间为 1 秒。
        duration: const Duration(seconds: 1),
        //添加了一个监听器，每当动画值更新时调用 setState，这会导致 Widget 重新构建，并刷新 UI。
      )
        ..addListener(() => setState(() {}))
        ..addStatusListener((status) {
          // 根据动画状态执行操作
          if (status == AnimationStatus.completed) {
            print('动画完成');
            _controller.reverse();
          }
          if (status == AnimationStatus.dismissed) {
            print('动画反向完成');
            _controller.forward();
          }
        });

      //定义了动画从 1.0 开始到 0.0 结束的值范围，并将其与 AnimationController 关联。
      _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller)
        //为 Tween 动画添加了一个状态监听器，根据动画的状态（完成或反向完成）来决定是反向播放还是正向播放。
        ..addStatusListener(
          (status) {
            if (status == AnimationStatus.completed ||
                status == AnimationStatus.dismissed) {
              _controller.repeat(reverse: true); //继续循环动画
            }
            // if (status == AnimationStatus.completed) {
            //   //动画完成时反向播放
            //   _controller.reverse();
            // } else if (status == AnimationStatus.dismissed) {
            //   //动画反向完成时正向播放
            //   _controller.forward();
            // }
          },
        );
      // 启动动画
      _controller.forward();
      //periodic:周期性
      //创建了一个周期性 Timer，每隔 1 秒触发一次。
      // _timer = Timer.periodic(
      //   const Duration(seconds: 1),
      //   (timer) {
      //     //如果动画已完成，则调用 _controller.reverse() 来反向播放动画。
      //     if (_controller.isCompleted) {
      //       _controller.reverse();
      //     } else {
      //       //继续正向播放动画。
      //       _controller.forward();
      //     }
      //   },
      // );
    }
  }

  @override
  void dispose() {
    // _timer.cancel();
    _controller.stop();
    // _controller.dispose();
    super.dispose();
  }

  //开始循环动画
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("透明度循环变化"),
      ),
      body: Center(
        child: AnimatedOpacity(
          opacity: _animation.value,
          duration: _controller.duration ?? const Duration(seconds: 1),
          child: Image.asset(
            "assets/talking.png",
            fit: BoxFit.fill,
            width: 140,
            height: 190,
          ),
        ),
      ),
    );
  }
}
*/

class AnimatedOpacityPage extends StatefulWidget {
  const AnimatedOpacityPage({super.key});

  @override
  State<AnimatedOpacityPage> createState() => _AnimatedOpacityPageState();
}

class _AnimatedOpacityPageState extends State<AnimatedOpacityPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener(
        (status) {
          // _controller.reverse();

          //根据动画状态执行操作
          if (status == AnimationStatus.completed) {
            _controller.reverse();
          }
          if (status == AnimationStatus.dismissed) {
            _controller.forward();
          }
        },
      );

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
    _controller.repeat(
        reverse: true); // 使用 AnimationController 的 repeat 方法来循环动画
    // ..addStatusListener(
    //   (status) {
    //     if (status == AnimationStatus.completed ||
    //         status == AnimationStatus.dismissed) {
    //       _controller.repeat(reverse: true); //继续循环动画
    //     }
    //   },
    // );
    //启动动画
    // _controller.forward();
  }

  @override
  void dispose() {
    // 先注销监听器
    _controller.removeListener(() => setState(() {}));
    _controller.removeStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("透明度循环变化"),
      ),
      body: Center(
        child: AnimatedOpacity(
          curve: Curves.linear, //线性变化

          opacity: _animation.value,
          duration: _controller.duration ?? const Duration(seconds: 1),
          child:
              // Container(
              //   width: 100,
              //   height: 100,
              //   color: Colors.red,
              // ),

              Image.asset(
            "assets/talking.png",
            fit: BoxFit.fill,
            width: 140,
            height: 190,
          ),
        ),
      ),
    );
  }
}
