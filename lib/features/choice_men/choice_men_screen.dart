import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovemageddon/features/choice_woman/choice_woman_screen.dart';
import 'package:lovemageddon/providers/providers.dart';

class ChoiceMenScreen extends ConsumerStatefulWidget {
  const ChoiceMenScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChoiceMenScreenState();
}

class _ChoiceMenScreenState extends ConsumerState<ChoiceMenScreen> {
  int _counter = 0;
  String? _selectedName;
  bool isFinished = false;
  final _formKey = GlobalKey<FormState>();

  void _incrementCounter(int numberOfMember) {
    final lastNum = numberOfMember - 1;
    if (_counter == lastNum) {
      setState(() {
        isFinished = true;
      });
    } else {
      setState(() {
        _counter++;
      });
    }
    _selectedName = null;
  }

  void _moveStep(BuildContext ctx) {
    Navigator.pushReplacement(
        ctx, MaterialPageRoute(builder: (ctx) => ChoiceWomanScreen()));
  }

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    final int numberOfMember = ref.watch(numberProvider);
    final List<String> womanNameList = ref.watch(womanNameProvider);
    final List<String> manNameList = ref.watch(manNameProvider);
    final Map<String, String?> womanSelectedList =
        ref.watch(womanSelectedProvider);
    final Map<int, int?> womanSelectedIntList =
        ref.watch(womanSelectedIntProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            (isFinished)
                ? const Text('次は男性が選ぶよ！')
                : Text('${womanNameList[_counter]}は誰を選ぶ？'),
            (isFinished)
                ? const Text('お楽しみに')
                : SizedBox(
                    width: _screenSize.width * 0.4,
                    child: Form(
                      key: _formKey,
                      child: DropdownButtonFormField(
                        validator: (value) {
                          if (value == null) {
                            return 'お相手を選んでね！';
                          }
                          return null;
                        },
                        hint: const Text('好きな人入れて'),
                        isExpanded: true,
                        value: _selectedName,
                        items: manNameList
                            .map((item) => DropdownMenuItem<String>(
                                  alignment: AlignmentDirectional.center,
                                  value: item,
                                  child: Text(item),
                                ))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _selectedName = value;
                          });
                        },
                      ),
                    ),
                  ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: _screenSize.width * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  if (!isFinished) {
                    if (_formKey.currentState!.validate()) {
                      final int manIndex = manNameList.indexOf(_selectedName!);
                      final int womanIndex =
                          womanNameList.indexOf(womanNameList[_counter]);
                      ref
                          .watch(womanSelectedIntProvider.notifier)
                          .state[womanIndex] = manIndex;

                      ref
                          .read(womanSelectedProvider.notifier)
                          .state[womanNameList[_counter]] = _selectedName;
                      print(womanSelectedList);
                      print(womanSelectedIntList);
                      _incrementCounter(numberOfMember);
                    }
                  } else {
                    _moveStep(context);
                  }
                },
                child: const Text('次へ'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
