import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  void _incrementCounter(int numberOfMember) {
    final lastNum = numberOfMember - 1;
    if (_counter == lastNum) {
      print('男性入力に遷移');
    } else {
      setState(() {
        _counter++;
        _selectedName = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    final int numberOfMember = ref.watch(numberProvider);
    final List<String> womanNameList = ref.watch(womanNameProvider);
    final List<String> manNameList = ref.watch(manNameProvider);
    final Map<String, String?> womanSelectedList =
        ref.watch(womanSelectedProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${womanNameList[_counter]}は誰を選ぶ？'),
            SizedBox(
              width: _screenSize.width * 0.4,
              child: DropdownButton(
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
            SizedBox(
              width: _screenSize.width * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  ref
                      .read(womanSelectedProvider.notifier)
                      .state[womanNameList[_counter]] = _selectedName;
                  print(womanSelectedList);
                  _incrementCounter(numberOfMember);
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
