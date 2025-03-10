import 'package:flutter/material.dart';
import 'package:siri_wave/siri_wave.dart';

class Siriwaveformios7 extends StatelessWidget {
  const Siriwaveformios7({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = IOS7SiriWaveformController(
      amplitude: 0.5, //表示波形的振幅，即波峰和波谷之间的距离
      color: Colors.red, //波形颜色
      frequency: 4, //表示波形的频率，即单位时间内波形的重复次数。值为 4，意味着波形较为密集。
      speed: 0.15, //表示波形的移动速度，值为 0.15，意味着波形移动相对较慢。
    );

    return SiriWaveform.ios7(
      controller: controller,
      options: IOS7SiriWaveformOptions(
        height: 180,
        width: double.infinity,
      ),
    );
  }
}
