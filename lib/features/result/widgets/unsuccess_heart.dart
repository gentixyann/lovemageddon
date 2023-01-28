import 'package:flutter/material.dart';

class UnsuccessHeart extends StatelessWidget {
  const UnsuccessHeart({super.key});

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return Container(
      width: _screenSize.width * 0.45,
      height: _screenSize.height * 0.2,
      child: Image.asset(
        'assets/images/unsuccess.png',
        fit: BoxFit.cover,
      ),
    );
    ;
  }
}
