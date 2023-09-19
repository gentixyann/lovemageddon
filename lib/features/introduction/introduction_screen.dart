import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final List<Map<String, dynamic>> _page = [
    {
      'image': 'assets/images/introduction',
      'title': '遊び方をざっくり教えるね',
      'description': 'モテマゲドンできることを祈ってます！',
    }
  ];

  final PageController _pageController = PageController();
  int _activePage = 0;

  _saveOptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 一度起動したらfirst_launchをfalseに設定する
    await prefs.setBool('first_launch', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            _saveOptions();
          },
          child: const Text('Click Me'),
        ),
      ),
    );
  }
}
