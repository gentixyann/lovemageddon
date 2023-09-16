import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovemageddon/features/choice_woman/choice_woman_screen.dart';
import 'package:lovemageddon/providers/providers.dart';
import 'package:lovemageddon/widgets/character.dart';

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
        ctx, MaterialPageRoute(builder: (ctx) => const ChoiceWomanScreen()));
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _screenSize.width * 0.1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: _screenSize.width * 0.9,
                height: _screenSize.height * 0.1,
                child: const Character(
                  num: 2,
                ),
              ),
              const SizedBox(height: 10),
              (isFinished)
                  ? Text(
                      '次は男性が選ぶよ！',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  : Column(
                      children: [
                        const Text('カップルになりたい相手を選んでね！'),
                        Text(
                          '「${womanNameList[_counter]}」は誰を選ぶ？',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
              const SizedBox(height: 40),
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
                          hint: const Text('誰が良い？'),
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
                        final int manIndex =
                            manNameList.indexOf(_selectedName!);
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
      ),
    );
  }
}
