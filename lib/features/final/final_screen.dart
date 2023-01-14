import 'package:flutter/material.dart';
import 'package:lovemageddon/features/number_members/number_members_screen.dart';

class FinalScreen extends StatelessWidget {
  const FinalScreen({super.key});

  void moveStep(BuildContext ctx) {
    Navigator.push(
        ctx, MaterialPageRoute(builder: (ctx) => const NumberMembersScreen()));
  }

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('お疲れ様でした！'),
            const Text('カップル成立した？'),
            const Text('成立した方々はぜひラブマゲドンして来てね！'),
            SizedBox(
              width: _screenSize.width * 0.7,
              child: ElevatedButton(
                onPressed: () => moveStep(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('もう一度'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
