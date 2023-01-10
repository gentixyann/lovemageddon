import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovemageddon/features/number_members/number_members_screen.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

// プロバイダー
final nicknameProvider = StateProvider<String>((ref) {
  // 変化するデータ
  return "ルビー";
});

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NumberMembersScreen(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  // ノティファイア でデータを変更する
  tapA(WidgetRef ref) {
    final notifier = ref.read(nicknameProvider.notifier);
    notifier.state = 'ルビーネコちゃん';
  }

  tapB(WidgetRef ref) {
    final notifier = ref.read(nicknameProvider.notifier);
    notifier.state = 'ルビーバード';
  }

  tapC(WidgetRef ref) {
    final notifier = ref.read(nicknameProvider.notifier);
    notifier.state = 'ルビーフィッシュ';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // データを見張っておく
    final nickname = ref.watch(nicknameProvider);
    return Scaffold(
      appBar: AppBar(title: Text(nickname)),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ニックネーム 2
            Text(nickname),
            // ボタン A
            ElevatedButton(onPressed: () => tapA(ref), child: const Text('A')),
            // ボタン B
            ElevatedButton(onPressed: () => tapB(ref), child: const Text('B')),
            // ボタン C
            ElevatedButton(onPressed: () => tapC(ref), child: const Text('C')),
            // ニックネーム 3
            Text(nickname),
          ],
        ),
      ),
    );
  }
}
