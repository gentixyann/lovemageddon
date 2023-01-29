import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovemageddon/features/woman_name/woman_name_screen.dart';
import 'package:lovemageddon/providers/providers.dart';

class NumberMembersScreen extends ConsumerStatefulWidget {
  const NumberMembersScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NumberMembersScreen();
}

class _NumberMembersScreen extends ConsumerState<NumberMembersScreen> {
  List<int> items = [3, 4, 5];
  int? _selectedItem;

  void _moveStep(BuildContext ctx) {
    Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => WomanNameScreen()));
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
              '2人1組でラブマゲドンしたい人数を入力してな',
            ),
            const SizedBox(height: 15),
            SizedBox(
                width: _screenSize.width * 0.4,
                child: DropdownButton(
                  hint: const Text('人数を選んで'),
                  isExpanded: true,
                  value: _selectedItem,
                  items: items
                      .map((item) => DropdownMenuItem<int>(
                            alignment: AlignmentDirectional.center,
                            value: item,
                            child: Text(item.toString()),
                          ))
                      .toList(),
                  onChanged: (int? value) {
                    ref.read(numberProvider.notifier).state = value!;
                    setState(() {
                      _selectedItem = value;
                    });
                  },
                )),
            const SizedBox(height: 40),
            SizedBox(
              width: _screenSize.width * 0.7,
              child: ElevatedButton(
                onPressed: () => _moveStep(context),
                child: const Text('次へ'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
