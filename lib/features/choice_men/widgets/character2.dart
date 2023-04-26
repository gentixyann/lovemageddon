import 'package:flutter/material.dart';

class Character2 extends StatelessWidget {
  const Character2({super.key});

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;

    return Align(
      alignment: const Alignment(-0.2, -1),
      child: SizedBox(
        width: _screenSize.width * 0.3,
        height: _screenSize.height * 0.3,
        child: Image.asset(
          'assets/images/character4.png',
        ),
      ),
    );
  }
}
