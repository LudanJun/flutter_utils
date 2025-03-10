import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class LottiePage extends StatefulWidget {
  const LottiePage({super.key});

  @override
  State<LottiePage> createState() => _LottiePageState();
}

class _LottiePageState extends State<LottiePage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: (5)),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("lottie动画"),
      ),
      body: Center(
        child: Column(
          children: [
            Lottie.asset(
              // 'assets/kaixue.json',
              'assets/data.json',
              frameRate: FrameRate.max,
              // controller: _controller,
              // animate: true,
              // onLoaded: (composition) {
              //   print(composition);
              //   _controller
              //     ?..duration = composition.duration
              //     ..forward().whenComplete(() {
              //       print("动画执行结束");
              //     });
              // },
            ),
            rainbowText(["ainia"]),
          ],
        ),
      ),
    );
  }

  Widget rainbowText(List<String> texts) {
    const colorizeColors = [
      // Colors.purple,
      Colors.white,
      Colors.blue,
      // Colors.yellow,
      Colors.red,
    ];
    const colorizeTextStyle = TextStyle(
      fontSize: 36.0,
      fontWeight: FontWeight.bold,
    );

    return SizedBox(
      width: 320.0,
      child: AnimatedTextKit(
        animatedTexts: texts
            .map((e) => ColorizeAnimatedText(
                  e,
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ))
            .toList(),
        isRepeatingAnimation: true,
        repeatForever: true,
        onTap: () {
          print("文字点击事件");
        },
      ),
    );
  }
}
