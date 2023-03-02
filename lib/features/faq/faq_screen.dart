import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _screenSize.width * 0.1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text('よくある質問など！')],
          ),
        ),
      ),
    );
  }
}
