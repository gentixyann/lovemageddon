import 'package:flutter/material.dart';

class Character1 extends StatelessWidget {
  const Character1({super.key});

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;

    return Image.asset(
      'assets/images/character1.png',
    );
  }
}
