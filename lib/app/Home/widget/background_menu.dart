import 'package:flutter/material.dart';

class BackgroundMenu extends StatelessWidget {
  const BackgroundMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        "assets/background.jpeg",
        fit: BoxFit.cover,
        colorBlendMode: BlendMode.darken,
        color: Colors.grey.withOpacity(0.2),
      ),
    );
  }
}
