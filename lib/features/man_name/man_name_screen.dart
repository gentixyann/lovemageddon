import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovemageddon/features/choice_men/choice_men_screen.dart';
import 'package:lovemageddon/providers/providers.dart';
import 'package:lovemageddon/theme/pallete.dart';

class ManNameScreen extends ConsumerStatefulWidget {
  const ManNameScreen({super.key});

  @override
  ConsumerState<ManNameScreen> createState() => _ManNameScreenState();
}

class _ManNameScreenState extends ConsumerState<ManNameScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<TextEditingController> _nameController = List.generate(
    5,
    (i) => TextEditingController(),
  );

  @override
  void dispose() {
    for (final controller in _nameController) {
      controller.dispose();
    }
    super.dispose();
  }

  void _moveStep(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(builder: (ctx) => const ChoiceMenScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final numberOfMember = ref.watch(numberProvider);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: '参加する'),
                      TextSpan(
                        text: '男性',
                        style: TextStyle(color: Pallete.secondaryColor),
                      ),
                      TextSpan(text: '陣の名前を入力してな〜'),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.8,
                  height: screenSize.height * 0.5,
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
                            hintText: '$memberIndexText人目の名前',
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.7,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Pallete.secondaryColor,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final nameList = [
                          for (int i = 0; i < numberOfMember; i++)
                            _nameController[i].text,
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
