import 'package:flutter/material.dart';
import 'package:lovemageddon/features/introduction/widgets/slide_section.dart';
import 'package:lovemageddon/features/start/start_screen.dart';
import 'package:lovemageddon/theme/pallete.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final List<Map<String, dynamic>> _pages = [
    {
      'image': 'assets/images/introduction/introduction.001.png',
      'title': '遊び方をざっくり教えるね',
      'description': 'モテマゲドンできることを祈ってます！',
    },
    {
      'image': 'assets/images/introduction/introduction.002.png',
      'title': 'まずは参加人数を選択',
      'description': '男性と女性の人数が違う場合は、架空の人物を使ったりして工夫してね！',
    },
    {
      'image': 'assets/images/introduction/introduction.003.png',
      'title': '参加者の名前を入力',
      'description': '女性陣が入力し終えたら次は男性陣が入力！\nドキドキ',
    },
    {
      'image': 'assets/images/introduction/introduction.004.png',
      'title': '誰と結ばれたいか選んでね',
      'description': '女性陣から順番にスマホを回して、気になるあの人を選んでみよう！',
    },
    {
      'image': 'assets/images/introduction/introduction.005.png',
      'title': '運命の瞬間',
      'description': '誰と誰が両想いだったか、見届けみよう❤️',
    }
  ];

  final PageController _pageController = PageController();
  int _activePage = 0;

  void onNextPage() {
    if (_activePage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.linear,
      );
    }
  }

  void _openStartScreen(BuildContext ctx) async {
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
        backgroundColor: Colors.white,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: _buildIndicator(),
                  ),
                  if (_activePage == 4)
                    SizedBox(
                      width: 160,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(42),
                          ),
                        ),
                        onPressed: () {
                          _saveOptions();
                          _openStartScreen(context);
                        },
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'はじめる',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: onNextPage,
                      child: const Icon(Icons.arrow_circle_right,
                          size: 50 // アイコンの大きさを設定できる
                          ),
                    )
                ],
              ),
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
