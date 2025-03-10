import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("导航"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              /// 点击购物车图标跳转到购物车页面
              Navigator.of(context).pushNamed("/JustAudioPage");
            },
            child: const Text("just_audio的使用"),
          ),
          ElevatedButton(
            onPressed: () {
              /// 点击购物车图标跳转到购物车页面
              Navigator.of(context).pushNamed("/CardWidgetPage");
            },
            child: const Text("card控件使用"),
          ),
          ElevatedButton(
            onPressed: () {
              /// 点击购物车图标跳转到购物车页面
              Navigator.of(context).pushNamed("/SiriWavePage");
            },
            child: const Text("SiriWave音频波浪控件使用"),
          ),
          ElevatedButton(
            onPressed: () {
              /// 点击购物车图标跳转到购物车页面
              Navigator.of(context).pushNamed("/PicJianbianPage");
            },
            child: const Text("图片渐变"),
          ),
          ElevatedButton(
            onPressed: () {
              /// 点击购物车图标跳转到购物车页面
              Navigator.of(context).pushNamed("/PicJianbianPage");
            },
            child: const Text("图片渐变"),
          ),
          ElevatedButton(
            onPressed: () {
              /// 点击购物车图标跳转到购物车页面
              Navigator.of(context).pushNamed("/AnimatedOpacityPage");
            },
            child: const Text("透明度变化"),
          ),
          ElevatedButton(
            onPressed: () {
              ///
              Navigator.of(context).pushNamed("/AnimationFadetransitionPage");
            },
            child: const Text("透明度变化2"),
          ),
          ElevatedButton(
            onPressed: () {
              /// 点击购物车图标跳转到购物车页面
              Navigator.of(context).pushNamed("/Animateddefaulttextstylepage");
            },
            child: const Text("...省略号依次变宽"),
          ),
          ElevatedButton(
            onPressed: () {
              /// 点击购物车图标跳转到购物车页面
              Navigator.of(context).pushNamed("/EllipsAnimationPage");
            },
            child: const Text("...省略号依次显示"),
          ),
          ElevatedButton(
            onPressed: () {
              /// 点击购物车图标跳转到购物车页面
              Navigator.of(context).pushNamed("/CusWavePage");
            },
            child: const Text("自定义波浪1"),
          ),
          ElevatedButton(
            onPressed: () {
              /// 点击购物车图标跳转到购物车页面
              Navigator.of(context).pushNamed("/FourSevenEightPage");
            },
            child: const Text("478呼吸法动画"),
          ),
          ElevatedButton(
            onPressed: () {
              /// 点击购物车图标跳转到购物车页面
              Navigator.of(context).pushNamed("/AnimationYinshiPage003");
            },
            child: const Text("隐式动画"),
          ),
          ElevatedButton(
            onPressed: () {
              /// 点击购物车图标跳转到购物车页面
              Navigator.of(context).pushNamed("/AnimationXianshiPage");
            },
            child: const Text("显示动画"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/AnimationJiaocuoPage");
            },
            child: const Text("交错动画"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/AnimationCusPage");
            },
            child: const Text("自定义动画"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/AnimationYuanliPage");
            },
            child: const Text("动画原理"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/AnimationCustomPainterPage");
            },
            child: const Text("操作底层动画"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/HooCusAnimationPage");
            },
            child: const Text("侯俊峰写的动画"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/AnimationBingtuPage");
            },
            child: const Text("圆饼图"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/AnimationWaveMicPage");
            },
            child: const Text("自定义波浪麦克风"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/LottiePage");
            },
            child: const Text("Lottie动画"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/AnsterQuestionPage");
            },
            child: const Text("回答问题进出动画"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/ScreenAdaptationPage");
            },
            child: const Text("屏幕适配"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/TextAnimationPage");
            },
            child: const Text("文字动效"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/AiniaAnimationPage");
            },
            child: const Text("ainia动画"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/LogoAnimationPage");
            },
            child: const Text("ainia logo 动画"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/AinaiPage");
            },
            child: const Text("ainia初版"),
          ),
        ],
      ),
    );
  }
}
