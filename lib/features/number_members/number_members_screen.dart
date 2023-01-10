import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// プロバイダー。この部分は別ファイルで切り出すべき？
final numberProvider = StateProvider<int?>((ref) {
  // 変化するデータ
  return 5;
});

class NumberMembersScreen extends ConsumerStatefulWidget {
  const NumberMembersScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NumberMembersScreen();
}

class _NumberMembersScreen extends ConsumerState<NumberMembersScreen> {
  List<int> items = [3, 4, 5];

  void confirmNumber(WidgetRef ref) {
    final notifier = ref.read(numberProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    final numberOfMember = ref.watch(numberProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '女性5人と男性5人なら「5」って具合に',
            ),
            const Text(
              'ラブマゲドンしたい人数を入力してな',
            ),
            Text(
              numberOfMember.toString(),
            ),
            const SizedBox(height: 15),
            Container(
                width: _screenSize.width * 0.2,
                child: DropdownButton(
                  isExpanded: true,
                  value: ref.watch(numberProvider),
                  items: items
                      .map((item) => DropdownMenuItem<int>(
                            alignment: AlignmentDirectional.center,
                            value: item,
                            child: Text(item.toString()),
                          ))
                      .toList(),
                  // onChanged: (item) => setState(() => selectedItem = item),
                  onChanged: (int? value) {
                    ref.read(numberProvider.notifier).state = value;
                  },
                )),
            const SizedBox(height: 40),
            SizedBox(
              width: _screenSize.width * 0.7,
              child: ElevatedButton(
                onPressed: () => confirmNumber(ref),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('次へ'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
