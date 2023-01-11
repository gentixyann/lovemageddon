import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovemageddon/providers/providers.dart';

class WomanNameScreen extends ConsumerWidget {
  const WomanNameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _screenSize = MediaQuery.of(context).size;
    final numberOfMember = ref.watch(numberProvider);

    List<TextEditingController> _nameController =
        List.generate(numberOfMember!, (i) => TextEditingController());

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '参加する女性陣の名前を入力してな〜',
          ),
          Text(numberOfMember.toString()),
          SizedBox(
            width: _screenSize.width * 0.8,
            height: _screenSize.height * 0.4,
            child: ListView.builder(
                itemCount: numberOfMember,
                itemBuilder: (BuildContext context, int index) {
                  int memberIndex = index + 1;
                  String memberIndexText = memberIndex.toString();
                  return TextFormField(
                    controller: _nameController[index],
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    decoration:
                        InputDecoration(hintText: '$memberIndexText人目の名前'),
                  );
                }),
          ),
          SizedBox(
            width: _screenSize.width * 0.7,
            child: ElevatedButton(
              onPressed: () {
                print(_nameController[0].text);
              },
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
    ));
  }
}
