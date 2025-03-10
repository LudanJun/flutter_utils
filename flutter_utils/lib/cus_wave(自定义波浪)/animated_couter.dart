import 'package:flutter/material.dart';

class AnimatedCounter extends StatelessWidget {
  //传入持续时间
  final Duration duration;
  //传入数字数据
  final int counter;
  //加上{}就可以有参数前缀提示
  const AnimatedCounter({
    super.key,
    required this.duration,
    required this.counter,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: duration,
      //只需要设置end就行了,begin开始有用
      tween: Tween(end: counter.toDouble()),
      builder: (context, value, child) {
        print(value);
        //获取整数部分
        final whole = value ~/ 1; //除完只取整数部分 3~/2 = 1
        //获取小数部分
        final decimal = value - whole;
        return Stack(
          children: [
            Positioned(
              top: -100 * decimal, // 0 -> -100 逐渐推出屏幕
              child: Opacity(
                opacity: 1.0 - decimal, //1.0 -> 0.0
                child: Text(
                  "$whole",
                  style: TextStyle(
                    fontSize: 100,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 100 - decimal * 100, //100 ->0 的效果
              child: Opacity(
                opacity: decimal, //0 -> 1.0
                child: Text(
                  "${whole + 1}",
                  style: TextStyle(
                    fontSize: 100,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
