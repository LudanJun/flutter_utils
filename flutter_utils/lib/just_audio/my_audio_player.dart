import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioPlayer {
  static final MyAudioPlayer _instance = MyAudioPlayer._internal();

  // 单例工厂方法
  factory MyAudioPlayer() => _instance;
  // 音频播放器
  final AudioPlayer audioPlayer = AudioPlayer();

  // 音频播放完成事件的订阅对象
  StreamSubscription<PlayerState>? _subscription;

  MyAudioPlayer._internal();

  int a = 0;

  void playAudio() async {
    String audioUrl =
        ""; //Get.find<ParameterController>().AudioUrl!.value; //获取音频URL

    // 取消之前的订阅
    _subscription?.cancel();

    // 监听音频播放完成事件
    _subscription = audioPlayer.playerStateStream.listen((PlayerState state) {
      if (state.processingState == ProcessingState.completed) {
        // 音频播放完成
        // 执行你的操作
        a++;
        print("音频播放完成$a");
      }
    });
    await audioPlayer.setUrl(audioUrl);
    await audioPlayer.play();
  }

//音频销毁
  void dispose() {
    audioPlayer.dispose();
    _subscription?.cancel(); // 取消订阅
  }
}

//音频的后缀是.mp3拖拽会出问题
class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final player = AudioPlayer();
  late StreamSubscription<Duration> _durationSubscription;

  double _sliderValue = 0.0;

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  void initAudioPlayer() async {
    await player.setUrl('a1f1258.wav');
  }

  void startAudio() async {
    player.play();
    _durationSubscription = player.positionStream.listen((position) {
      if (player.duration != null) {
        setState(() {
          _sliderValue = position.inMilliseconds.toDouble() /
              player.duration!.inMilliseconds.toDouble();
        });
      }
    });
  }

  // 继续播放
  void resume() {
    player.play();
  }

  void stopAudio() async {
    await player.pause();
  }

  void seekToPosition(double value) {
    final duration = player.duration;
    final newPosition = duration! * value;
    player.seek(newPosition);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text('Play'),
            onPressed: () {
              startAudio();
              // resume();
            },
          ),
          ElevatedButton(
            child: Text('Stop'),
            onPressed: () {
              stopAudio();
            },
          ),
          Slider(
            value: _sliderValue,
            min: 0.0,
            max: 1.01,
            onChanged: (double value) {
              setState(() {
                _sliderValue = value;
              });
              seekToPosition(value);
            },
            activeColor: Colors.blue, // 设置进度条颜色为蓝色
            inactiveColor: Colors.white, // 设置底部颜色为灰色
          ),
        ],
      ),
    );
  }
}

class MyPageAudioPlayer {
  static final MyPageAudioPlayer _instance = MyPageAudioPlayer._internal();
  factory MyPageAudioPlayer() => _instance;

  final AudioPlayer audioPlayer = AudioPlayer();
  StreamSubscription<PlayerState>? _subscription;
  MyPageAudioPlayer._internal();
  Future<int> playAudio(String audioUrl) async {
    int pageState = 0;
    Completer<int> completer = Completer<int>();
    await audioPlayer.setUrl(audioUrl);
    await audioPlayer.play();

    _subscription?.cancel(); // 取消之前的订阅

    _subscription = audioPlayer.playerStateStream.listen((PlayerState state) {
      if (state.processingState == ProcessingState.completed) {
        pageState = 666;
        completer.complete(pageState); // 完成并返回结果
        print("音频播放完成---------------11---监听---结束-----------");
      }
    });

    return completer.future;
  }

  void stop() {
    audioPlayer.stop();

    _subscription?.cancel();
  }

  void dispose() {
    audioPlayer.stop();
    _subscription?.cancel();
  }
}
