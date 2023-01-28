import 'package:flutter/material.dart';

class SuccessHeart extends StatelessWidget {
  const SuccessHeart({super.key});

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return Container(
      width: 100,
      height: 100,
      child: Image.asset(
        'assets/images/success.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
