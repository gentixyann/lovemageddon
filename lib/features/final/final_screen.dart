import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovemageddon/features/number_members/number_members_screen.dart';

class FinalScreen extends ConsumerWidget {
  const FinalScreen({super.key});

  void _moveStep(BuildContext ctx) {
    Navigator.push(
        ctx, MaterialPageRoute(builder: (ctx) => const NumberMembersScreen()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                onPressed: () => _moveStep(context),
                child: const Text('もう一度'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
