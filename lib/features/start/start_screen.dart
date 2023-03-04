import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lovemageddon/features/faq/faq_screen.dart';
import 'package:lovemageddon/features/number_members/number_members_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  void _moveStep(BuildContext ctx) {
    Navigator.pushReplacement(
        ctx, MaterialPageRoute(builder: (ctx) => const NumberMembersScreen()));
  }

  void _moveFaq(BuildContext ctx) {
    Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => const FaqScreen()));
  }

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _screenSize.width * 0.1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: _screenSize.width * 0.8,
                height: _screenSize.height * 0.3,
                child: Image.asset(
                  'assets/images/title.png',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/images/item2.png',
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/images/item1.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              const Text('カップル成立するかな？'),
              const SizedBox(height: 40),
              SizedBox(
                width: _screenSize.width * 0.7,
                child: ElevatedButton(
                  onPressed: () => _moveStep(context),
                  child: const Text('スタート'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: _screenSize.width * 0.7,
                child: ElevatedButton(
                  onPressed: () => _moveFaq(context),
                  child: const Text('FAQなど'),
                ),
              ),
              const SizedBox(height: 40),
              RichText(
                text: TextSpan(
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                    text: "プライバシーポリシー",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        final uri =
                            Uri.parse("https://gengendiary.world/post-660/");
                        launchUrl(uri);
                      }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
