import 'package:flutter/material.dart';

class CardWidgetPage extends StatefulWidget {
  const CardWidgetPage({super.key});

  @override
  State<CardWidgetPage> createState() => _CardWidgetPageState();
}

class _CardWidgetPageState extends State<CardWidgetPage> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: Colors.amber,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        elevation: 0,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
            border: Border.all(
              width: 8.0,
              color: colorScheme.secondary,
            ),
          ),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: colorScheme.onSecondary,
            foregroundImage: AssetImage("assets/profile.character.1.png"),
          ),
        ),
      ),
    );
  }
}
