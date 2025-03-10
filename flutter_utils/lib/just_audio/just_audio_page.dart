import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

/*
// 播放音频的状态
enum SDAudioPlayerState {
  idle, // 默认
  loading, // 加载中
  buffering, // 缓存中
  ready, // 可播放
  completed, // 播放完成
}

// 播放音频出现错误
class SDAudioPlayerError {
  String? message;
}

// 播放回调
typedef SDAudioPlayerCallBack = void Function(
    SDAudioPlayerState state, SDAudioPlayerError? error);

// 定义优先级的类
class SDMusicConfig {
  // 音频文件地址
  late String audioUrl = '';

  late bool runLoop = false;

  var audioPriority; // 是否循环播放

  // 构造函数
  SDMusicConfig(this.audioUrl, this.audioPriority, this.runLoop);
}

// 播放音频文件
class SDMusicPlayer {
  // 音频播放
  late AudioPlayer _audioPlayer;

  // 优先级
  late SDMusicConfig _musicConfig;

  late bool _playing = false; // 是否正在播放

  late SDAudioPlayerState _playerState = SDAudioPlayerState.idle; // 状态

  late SDAudioPlayerCallBack? _playerCallBack;

  SDMusicPlayer(this._audioPlayer, this._musicConfig) {
    setAudioUrl(this._musicConfig.audioUrl);
    openPlayCallBack((state, error) {});
  }

  SDMusicConfig getMusicConfig() {
    return _musicConfig;
  }

  void openPlayCallBack(SDAudioPlayerCallBack playerCallBack) {
    _playerCallBack = playerCallBack;
    _audioPlayer.playerStateStream.listen((state) {
      _playing = state.playing;

      switch (state.processingState) {
        case ProcessingState.idle:
          {
            _playerState = SDAudioPlayerState.idle;
            break;
          }
        case ProcessingState.loading:
          {
            _playerState = SDAudioPlayerState.loading;
            break;
          }
        case ProcessingState.buffering:
          {
            _playerState = SDAudioPlayerState.buffering;
            break;
          }
        case ProcessingState.ready:
          {
            _playerState = SDAudioPlayerState.ready;
            break;
          }
        case ProcessingState.completed:
          {
            _playerState = SDAudioPlayerState.completed;
            if (_musicConfig.runLoop == true) {
              // 循环播放的时候
              seek(Duration.zero);
              play();
            } else {
              stop();
            }
            break;
          }

        default:
      }

      if (_playerCallBack != null) {
        _playerCallBack!(_playerState, null);
      }
    });
  }

  // var duration = await player.setUrl('https://foo.com/bar.mp3');
  Future<void> setAudioUrl(String url) async {
    SDAudioPlayerError? error;
    if (url.isNotEmpty) {
      // Set the audio source but manually load audio at a later point.
      try {
        _audioPlayer.setUrl(url, preload: true);
        // Acquire platform decoders and start loading audio.
        var duration = await _audioPlayer.load();
        print("url：${url} duration：${duration}");
      } on PlayerException catch (e) {
        // iOS/macOS: maps to NSError.code
        // Android: maps to ExoPlayerException.type
        // Web: maps to MediaError.code
        // Linux/Windows: maps to PlayerErrorCode.index
        print("SDAudioPlayer Error code: ${e.code}");
        // iOS/macOS: maps to NSError.localizedDescription
        // Android: maps to ExoPlaybackException.getMessage()
        // Web/Linux: a generic message
        // Windows: MediaPlayerError.message
        print("SDAudioPlayer Error message: ${e.message}");
        error = SDAudioPlayerError();
        error.message = e.message;
      } on PlayerInterruptedException catch (e) {
        // This call was interrupted since another audio source was loaded or the
        // player was stopped or disposed before this audio source could complete
        // loading.
        // LoggerManager()
        //     .debug("SDAudioPlayer Connection aborted: ${e.message}");
        print("SDAudioPlayer Connection aborted: ${e.message}");
        error = SDAudioPlayerError();
        error.message = e.message;
      } catch (e) {
        // Fallback for all errors
        print("e: ${e}");
        error = SDAudioPlayerError();
        error.message = e.toString();
      }
    } else {
      error = SDAudioPlayerError();
      error.message = '播放地址不能为空';
    }

    if (_playerCallBack != null) {
      _playerCallBack!(_playerState, error);
    }
  }

  void play() async {
    // Usually you don't want to wait for playback to finish.
    if (_musicConfig.audioUrl != null && _musicConfig.audioUrl.isNotEmpty) {
      if (_playing == false) {
        // 正在播放
        await _audioPlayer.play();
      }
    }
  }

  void pause() async {
    if (_musicConfig.audioUrl != null && _musicConfig.audioUrl.isNotEmpty) {
      await _audioPlayer.pause();
    }
  }

  void stop() async {
    if (_musicConfig.audioUrl != null && _musicConfig.audioUrl.isNotEmpty) {
      await _audioPlayer.pause();
      await _audioPlayer.seek(Duration.zero);
    }
  }

  void seek(Duration position) async {
    if (_musicConfig.audioUrl != null && _musicConfig.audioUrl.isNotEmpty) {
      await _audioPlayer.seek(position);
    }
  }

  void setVolume(double volume) async {
    if (_musicConfig.audioUrl != null && _musicConfig.audioUrl.isNotEmpty) {
      await _audioPlayer.setVolume(volume);
    }
  }

  // 不需要该播放器，则需要调用该方法
  void dispose() async {
    await _audioPlayer.dispose();
  }
}
*/
class JustAudioPage extends StatefulWidget {
  const JustAudioPage({super.key});

  @override
  State<JustAudioPage> createState() => _JustAudioPageState();
}

class _JustAudioPageState extends State<JustAudioPage> {
  final AudioPlayer audioPlayer = AudioPlayer();

  //  AudioPlayer _audioPlayer = AudioPlayer(); // Create a player
  // final SDMusicPlayer auplayer =
  //     SDMusicPlayer(AudioPlayer(), SDMusicConfig("", true, true));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _audioPlayer
    //     .setAudioSource(
    //   ConcatenatingAudioSource(
    //     children: [
    //       AudioSource.uri(
    //         Uri.parse(
    //             "http://music.163.com/song/media/outer/url?id=447925558.mp3"),
    //       ),
    //     ],
    //   ),
    // )
    //     .catchError((error) {
    //   print(error);
    // });

    // 监听音频播放完成事件
    audioPlayer.playerStateStream.listen((PlayerState state) {
      if (state.processingState == ProcessingState.idle) {
        print("------------播放器尚未加载-----------------");
      }
      if (state.processingState == ProcessingState.loading) {
        print("------------播放器正在加载-----------------");
      }
      if (state.processingState == ProcessingState.buffering) {
        print("------------播放器正在缓冲音频-----------------");
      }
      if (state.processingState == ProcessingState.ready) {
        print("------------播放器有足够的音频缓冲区-----------------");
      }
      if (state.processingState == ProcessingState.completed) {
        // 音频播放完成
        // 执行你的操作
        print("------------音频播放完成-----------------");
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _audioPlayer.dispose();
  }

  // Widget _playerButton(PlayerState playerState) {
  //   // 1
  //   final processingState = playerState.processingState;
  //   if (processingState == ProcessingState.loading ||
  //       processingState == ProcessingState.buffering) {
  //     // 2
  //     return Container(
  //       margin: EdgeInsets.all(8.0),
  //       width: 64.0,
  //       height: 64.0,
  //       child: CircularProgressIndicator(),
  //     );
  //   } else if (_audioPlayer.playing != true) {
  //     // 3
  //     return IconButton(
  //       icon: Icon(Icons.play_arrow),
  //       iconSize: 64.0,
  //       onPressed: _audioPlayer.play,
  //     );
  //   } else if (processingState != ProcessingState.completed) {
  //     // 4
  //     return IconButton(
  //       icon: Icon(Icons.pause),
  //       iconSize: 64.0,
  //       onPressed: _audioPlayer.pause,
  //     );
  //   } else {
  //     // 5
  //     return IconButton(
  //       icon: Icon(Icons.replay),
  //       iconSize: 64.0,
  //       onPressed: () => _audioPlayer.seek(Duration.zero,
  //           index: _audioPlayer.effectiveIndices?.first),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("just_audio"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await audioPlayer.setUrl(
                'https://dashanbook.oss-cn-shenzhen.aliyuncs.com/av/2023/12/04/fbcd583f278c4c2fa0c83fcfc6fc08b4.mp3');
            await audioPlayer.play();
          },
          child: Icon(
            audioPlayer.playing ? Icons.pause : Icons.play_arrow,
            size: 48.0,
          ),
        ),
      ),
    );
  }
}
