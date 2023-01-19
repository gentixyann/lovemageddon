import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovemageddon/providers/providers.dart';

class WomanCircles extends ConsumerWidget {
  const WomanCircles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _screenSize = MediaQuery.of(context).size;
    final int numberOfMember = ref.watch(numberProvider);
    final List<String> womanNameList = ref.watch(womanNameProvider);

    return SizedBox(
      width: _screenSize.width * 0.2,
      height: _screenSize.height * 0.9,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: numberOfMember,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding:
                  EdgeInsets.symmetric(vertical: _screenSize.height * 0.04),
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(womanNameList[index]),
                ],
              ),
            );
          }),
    );
  }
}
