import 'package:flutter/material.dart';
import 'package:lovemageddon/features/introduction/widgets/slide_section.dart';
import 'package:lovemageddon/features/start/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final List<Map<String, dynamic>> _pages = [
    {
      'image': 'assets/images/introduction',
      'title': '遊び方をざっくり教えるね',
      'description': 'モテマゲドンできることを祈ってます！',
    }
  ];

  final PageController _pageController = PageController();
  int _activePage = 0;

  void _onNextPage() {
    if (_activePage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.linear,
      );
    }
  }

  Future<void> _openStartScreen(BuildContext ctx) async {
    await Navigator.pushAndRemoveUntil(
      ctx,
      MaterialPageRoute(
        builder: (context) => const StartScreen(),
      ),
      (_) => false,
    );
  }

  _saveOptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 一度起動したらfirst_launchをfalseに設定する
    await prefs.setBool('first_launch', false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            right: 20,
            bottom: 60,
            left: 20,
          ),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (int page) {
                    setState(() {
                      _activePage = page;
                    });
                  },
                  itemBuilder: (BuildContext ctx, int index) => SlideSection(
                    image: _pages[index]['image'],
                    title: _pages[index]['title'],
                    description: _pages[index]['description'],
                  ),
                ),
              ),
              Row()
            ],
          ),
        ),
      );

  List<Widget> _buildIndicator() {
    final indicators = <Widget>[];

    for (var i = 0; i < _pages.length; i++) {
      if (_activePage == i) {
        indicators.add(_indicatorsTrue());
      } else {
        indicators.add(_indicatorsFalse());
      }
    }
    return indicators;
  }

  Widget _indicatorsTrue() => AnimatedContainer(
        duration: const Duration(microseconds: 3000),
        height: 8,
        width: 8,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color.fromRGBO(18, 20, 22, 1),
        ),
      );

  Widget _indicatorsFalse() => AnimatedContainer(
        duration: const Duration(microseconds: 3000),
        height: 8,
        width: 8,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[300],
        ),
      );
}
