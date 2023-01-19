import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovemageddon/providers/providers.dart';

class ManCircles extends ConsumerWidget {
  const ManCircles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _screenSize = MediaQuery.of(context).size;
    final int numberOfMember = ref.watch(numberProvider);
    final List<String> manNameList = ref.watch(manNameProvider);

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
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(manNameList[index]),
                ],
              ),
            );
          }),
    );
  }
}
