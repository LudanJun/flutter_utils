import 'package:flutter/material.dart';
import 'package:siri_wave/siri_wave.dart';

class Siriwaveformios9 extends StatelessWidget {
  const Siriwaveformios9({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = IOS9SiriWaveformController(
      amplitude: 1, //表示波形的振幅，即波峰和波谷之间的距离
      speed: 0.15, //表示波形的移动速度，值为 0.15，意味着波形移动相对较慢。
    );
    return SiriWaveform.ios9(
      controller: controller,
      options: IOS9SiriWaveformOptions(
        height: 180,
        width: 360,
      ),
    );
  }
}
