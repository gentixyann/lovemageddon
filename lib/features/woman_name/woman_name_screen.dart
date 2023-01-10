import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovemageddon/providers/providers.dart';

class WomanNameScreen extends ConsumerWidget {
  const WomanNameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberOfMember = ref.watch(numberProvider);
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '参加する女性陣の名前を入力してね〜',
          ),
          Text(numberOfMember.toString())
        ],
      ),
    ));
  }
}
