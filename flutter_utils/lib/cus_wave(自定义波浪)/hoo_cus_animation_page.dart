import 'package:flutter/material.dart';
import 'package:flutter_utils/cus_wave(%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B3%A2%E6%B5%AA)/bolangxianWidget.dart';
import 'package:flutter_utils/cus_wave(%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B3%A2%E6%B5%AA)/mic/mic_waveform.dart';
import 'package:flutter_utils/cus_wave(%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B3%A2%E6%B5%AA)/mic/mic_waveform_controller.dart';

class HooCusAnimationPage extends StatefulWidget {
  const HooCusAnimationPage({super.key});

  @override
  State<HooCusAnimationPage> createState() => _HooCusAnimationPageState();
}

class _HooCusAnimationPageState extends State<HooCusAnimationPage> {
  @override
  Widget build(BuildContext context) {
    final controller = MicWaveformController(
      waveHeight: 0.5,
      waveSize: 3,
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: MicWaveformWidget(controller: controller),
            ),
            SizedBox(
              height: 100,
            ),
            //amplitude  振幅
            //frequency 频率
            //speed 速度
            //phase 相位
            // Bolangxianwidget(amplitude: 10, frequency: 2, speed: 1),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        print("add");
      }),
    );
  }
}
