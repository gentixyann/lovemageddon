import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovemageddon/features/choice_men/choice_men_screen.dart';
import 'package:lovemageddon/providers/providers.dart';

class ManNameScreen extends ConsumerWidget {
  ManNameScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  List<TextEditingController> _nameController =
      List.generate(5, (i) => TextEditingController());

  void _moveStep(BuildContext ctx) {
    Navigator.push(
        ctx, MaterialPageRoute(builder: (ctx) => const ChoiceMenScreen()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _screenSize = MediaQuery.of(context).size;
    final numberOfMember = ref.watch(numberProvider);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: _screenSize.width * 0.1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '参加する男性陣の名前を入力してな〜',
                ),
                SizedBox(
                  width: _screenSize.width * 0.8,
                  height: _screenSize.height * 0.5,
                  child: Form(
                    key: _formKey,
                    child: ListView.builder(
                        itemCount: numberOfMember,
                        itemBuilder: (BuildContext context, int index) {
                          int memberIndex = index + 1;
                          String memberIndexText = memberIndex.toString();
                          return TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '名前入れてね！';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            controller: _nameController[index],
                            maxLength: 5,
                            maxLines: 1,
                            decoration: InputDecoration(
                                hintText: '$memberIndexText人目の名前'),
                          );
                        }),
                  ),
                ),
                SizedBox(
                  width: _screenSize.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final nameList = [
                          for (int i = 0; i < numberOfMember; i++)
                            _nameController[i].text
                        ];
                        ref.read(manNameProvider.notifier).state = nameList;
                        _moveStep(context);
                      }
                    },
                    child: const Text('次へ'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
