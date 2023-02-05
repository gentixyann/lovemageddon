import 'package:flutter/material.dart';

class SuccessHeart extends StatelessWidget {
  const SuccessHeart({super.key});

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return Container(
      width: _screenSize.width * 0.4,
      height: _screenSize.height * 0.2,
      child: Image.asset(
        'assets/images/success.png',
      ),
    );
  }
}
