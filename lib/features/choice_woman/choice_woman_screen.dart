import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovemageddon/features/result/result_screen.dart';
import 'package:lovemageddon/features/result/result_screen2.dart';
import 'package:lovemageddon/providers/providers.dart';

class ChoiceWomanScreen extends ConsumerStatefulWidget {
  const ChoiceWomanScreen({super.key});

  @override
  ConsumerState<ChoiceWomanScreen> createState() => _ChoiceWomanScreenState();
}

class _ChoiceWomanScreenState extends ConsumerState<ChoiceWomanScreen> {
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
        ctx, MaterialPageRoute(builder: (ctx) => ResultScreen2()));
  }

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    final int numberOfMember = ref.watch(numberProvider);
    final List<String> womanNameList = ref.watch(womanNameProvider);
    final List<String> manNameList = ref.watch(manNameProvider);
    final Map<String, String?> manSelectedList = ref.watch(manSelectedProvider);
    final Map<int, int?> manSelectedIntList = ref.watch(manSelectedIntProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            (isFinished)
                ? const Text('次はマッチングできたか確認')
                : Text('${manNameList[_counter]}は誰を選ぶ？'),
            (isFinished)
                ? const Text('お楽しみに')
                : SizedBox(
                    width: _screenSize.width * 0.4,
                    child: Form(
                      key: _formKey,
                      child: DropdownButtonFormField(
                        hint: const Text('好きな人入れて'),
                        isExpanded: true,
                        value: _selectedName,
                        items: womanNameList
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
            SizedBox(
              width: _screenSize.width * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  if (!isFinished) {
                    if (_formKey.currentState!.validate()) {
                      final int womanIndex =
                          womanNameList.indexOf(_selectedName!);
                      final int manIndex =
                          manNameList.indexOf(manNameList[_counter]);

                      ref
                          .watch(manSelectedIntProvider.notifier)
                          .state[manIndex] = womanIndex;
                      ref
                          .read(manSelectedProvider.notifier)
                          .state[manNameList[_counter]] = _selectedName;
                      print(manSelectedList);
                      print(manSelectedIntList);
                      _incrementCounter(numberOfMember);
                    }
                  } else {
                    _moveStep(context);
                  }
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
      ),
    );
  }
}
