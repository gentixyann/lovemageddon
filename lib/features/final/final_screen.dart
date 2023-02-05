import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovemageddon/features/start/start_screen.dart';

class FinalScreen extends ConsumerWidget {
  const FinalScreen({super.key});

  void _moveStep(BuildContext ctx) {
    Navigator.pushReplacement(
        ctx, MaterialPageRoute(builder: (ctx) => const StartScreen()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _screenSize.width * 0.1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'お疲れ様でした！',
              ),
              const SizedBox(height: 40),
              Text(
                'カップル成立した？',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                '成立した方々はぜひラブマゲドンして来てね！',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: _screenSize.width * 0.7,
                child: ElevatedButton(
                  onPressed: () => _moveStep(context),
                  child: const Text('もう一度'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
