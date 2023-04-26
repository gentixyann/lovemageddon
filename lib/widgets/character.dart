import 'package:flutter/material.dart';

class Character extends StatelessWidget {
  final int num;
  const Character({
    super.key,
    required this.num,
  });

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;

    return Image.asset(
      'assets/images/character$num.png',
    );
  }
}
