import 'package:flutter/material.dart';
import 'package:flutter_utils/siri_wave/SiriWaveformios7.dart';
import 'package:flutter_utils/siri_wave/Siriwaveformios9.dart';
import 'package:siri_wave/siri_wave.dart';

class SiriWavePage extends StatefulWidget {
  const SiriWavePage({super.key});

  @override
  State<SiriWavePage> createState() => _SiriWavePageState();
}

class _SiriWavePageState extends State<SiriWavePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("音频波浪"),
      ),
      body: Container(
        height: double.infinity,
        child: Center(
          child: Column(
            children: [
              Siriwaveformios7(),
              Siriwaveformios9(),
            ],
          ),
        ),
      ),
    );
  }
}
