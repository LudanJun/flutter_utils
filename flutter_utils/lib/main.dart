import 'package:flutter/material.dart';
import 'package:flutter_utils/%20EllipsisAnimationState(%E7%9C%81%E7%95%A5%E5%8F%B7%E4%BE%9D%E6%AC%A1%E6%98%BE%E7%A4%BA)/%20Ellipsis_Animation_State_Page.dart';
import 'package:flutter_utils/%E6%96%87%E5%AD%97%E5%8A%A8%E6%95%88/text_animation_page.dart';
import 'package:flutter_utils/AnimatedDefaultTextStyle/AnimatedDefaultTextStylePage.dart';
import 'package:flutter_utils/AnimatedOpacity(%E9%80%8F%E6%98%8E%E5%BA%A6)/animated_opacity_page.dart';
import 'package:flutter_utils/AnimatedOpacity(%E9%80%8F%E6%98%8E%E5%BA%A6)/animation_fadeTransition_page.dart';
import 'package:flutter_utils/Lottie(%E5%8A%A8%E7%94%BB)/lottie_page.dart';
import 'package:flutter_utils/ScreenAdaptation/screen_adaptation_page.dart';
import 'package:flutter_utils/ainia%E5%8A%A8%E7%94%BB/ainai_page.dart';
import 'package:flutter_utils/ainia%E5%8A%A8%E7%94%BB/ainia_animation_page.dart';
import 'package:flutter_utils/ainia%E5%8A%A8%E7%94%BB/logo_animation_page.dart';
import 'package:flutter_utils/card_widget/card_widget_page.dart';
import 'package:flutter_utils/cus_wave(%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B3%A2%E6%B5%AA)/001cus_wave_page.dart';
import 'package:flutter_utils/cus_wave(%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B3%A2%E6%B5%AA)/006animation_cus_page.dart';
import 'package:flutter_utils/cus_wave(%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B3%A2%E6%B5%AA)/005animation_jiaocuo_page.dart';
import 'package:flutter_utils/cus_wave(%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B3%A2%E6%B5%AA)/004animation_xianshi_page.dart';
import 'package:flutter_utils/cus_wave(%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B3%A2%E6%B5%AA)/003animation_yinshi_page.dart';
import 'package:flutter_utils/cus_wave(%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B3%A2%E6%B5%AA)/002four_seven_eight_page.dart';
import 'package:flutter_utils/cus_wave(%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B3%A2%E6%B5%AA)/007animation_yuanli_page.dart';
import 'package:flutter_utils/cus_wave(%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B3%A2%E6%B5%AA)/008animation_custom_painter_page.dart';
import 'package:flutter_utils/cus_wave(%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B3%A2%E6%B5%AA)/009animation_bingtu_page.dart';
import 'package:flutter_utils/cus_wave(%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B3%A2%E6%B5%AA)/010animation_wave_mic_page.dart';
import 'package:flutter_utils/cus_wave(%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B3%A2%E6%B5%AA)/011anster_question_age.dart';
import 'package:flutter_utils/cus_wave(%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B3%A2%E6%B5%AA)/hoo_cus_animation_page.dart';
import 'package:flutter_utils/home_page.dart';
import 'package:flutter_utils/just_audio/just_audio_page.dart';
import 'package:flutter_utils/pic_jianbian/pic_jianbian_page.dart';
import 'package:flutter_utils/siri_wave/siri_wave_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
      initialRoute: '/homePage',
      routes: <String, WidgetBuilder>{
        '/homePage': (BuildContext context) => const HomePage(),
        '/JustAudioPage': (BuildContext context) => const JustAudioPage(),
        '/CardWidgetPage': (BuildContext context) => const CardWidgetPage(),
        '/SiriWavePage': (BuildContext context) => const SiriWavePage(),
        '/PicJianbianPage': (BuildContext context) => const PicJianbianPage(),
        '/AnimatedOpacityPage': (BuildContext context) =>
            const AnimatedOpacityPage(),
        '/AnimationFadetransitionPage': (BuildContext context) =>
            const AnimationFadetransitionPage(),
        '/Animateddefaulttextstylepage': (BuildContext context) =>
            const Animateddefaulttextstylepage(),
        '/EllipsAnimationPage': (BuildContext context) =>
            const EllipsAnimationPage(),
        '/CusWavePage': (BuildContext context) => const CusWavePage(),
        '/FourSevenEightPage': (BuildContext context) =>
            const FourSevenEightPage(),
        '/AnimationYinshiPage003': (BuildContext context) =>
            const AnimationYinshiPage003(),
        '/AnimationXianshiPage': (BuildContext context) =>
            const AnimationXianshiPage(),
        '/AnimationJiaocuoPage': (BuildContext context) =>
            const AnimationJiaocuoPage(),
        '/AnimationCusPage': (BuildContext context) => const AnimationCusPage(),
        '/AnimationYuanliPage': (BuildContext context) =>
            const AnimationYuanliPage(),
        '/AnimationCustomPainterPage': (BuildContext context) =>
            const AnimationCustomPainterPage(),
        '/HooCusAnimationPage': (BuildContext context) =>
            const HooCusAnimationPage(),
        '/AnimationBingtuPage': (BuildContext context) =>
            const AnimationBingtuPage(),
        '/AnimationWaveMicPage': (BuildContext context) => AnimationWaveMicPage(
              durationTime: 800,
              color: Color(0xFF7744DC),
              // waveHeight: 0.5,
              // waveSize: 0.3,
            ),
        '/LottiePage': (BuildContext context) => const LottiePage(),
        '/AnsterQuestionPage': (BuildContext context) =>
            const AnsterQuestionPage(),
        '/ScreenAdaptationPage': (BuildContext context) =>
            const ScreenAdaptationPage(),
        '/TextAnimationPage': (BuildContext context) =>
            const TextAnimationPage(),
        '/AiniaAnimationPage': (BuildContext context) =>
            const AiniaAnimationPage(),
        '/LogoAnimationPage': (BuildContext context) =>
            const LogoAnimationPage(),
        '/AinaiPage': (BuildContext context) =>
            const AinaiPage(),
        
      },
    );
  }
}
