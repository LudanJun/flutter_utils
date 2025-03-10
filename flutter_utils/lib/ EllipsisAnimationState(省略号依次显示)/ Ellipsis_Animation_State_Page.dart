import 'package:flutter/material.dart';

class EllipsAnimationPage extends StatefulWidget {
  const EllipsAnimationPage({super.key});

  @override
  State<EllipsAnimationPage> createState() => _EllipsAnimationPageState();
}

class _EllipsAnimationPageState extends State<EllipsAnimationPage> {
  String ellipsisText = '';

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  void startAnimation() async {
    while (true) {
      await Future.delayed(Duration(milliseconds: 500));
      if (mounted) {
        setState(() {
          if (ellipsisText.length < 3) {
            ellipsisText += '.';
          } else {
            ellipsisText = '';
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("省略号依次显示"),
      ),
      body: Center(
        child: Text(
          'Talking$ellipsisText',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
