import 'package:flutter/material.dart';

//屏幕适配
class ScreenAdaptationPage extends StatefulWidget {
  const ScreenAdaptationPage({super.key});

  @override
  State<ScreenAdaptationPage> createState() => _ScreenAdaptationPageState();
}

class _ScreenAdaptationPageState extends State<ScreenAdaptationPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //设计尺寸：430 × 932 pt 、分辨率：1290 × 2796 px 、倍数：@3x
        //ipad air 11寸  width:820 height:1180  pt
        print("constraints:${constraints.maxWidth}"); //430

        print("constraints:${constraints.maxHeight}"); //932
        if (constraints.maxWidth > 600) {
          return Scaffold(
            appBar: AppBar(
              title: Text("屏幕适配"),
            ),
            body: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.amber,
                )
              ],
            ),
          );
        } else {
          return Container(
            width: 200,
            height: 200,
            color: Colors.red,
          );
        }
      },
    );
  }
}
