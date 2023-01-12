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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    final numberOfMember = ref.watch(numberProvider);
    final womanNameList = ref.watch(womanNameProvider);
    final manNameList = ref.watch(manNameProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${womanNameList[_counter]}は誰を選ぶ？'),
            SizedBox(
              width: _screenSize.width * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  _incrementCounter();
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
