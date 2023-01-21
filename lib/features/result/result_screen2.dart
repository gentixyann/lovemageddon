import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovemageddon/features/result/widgets/beam_circles.dart';
import 'package:lovemageddon/features/result/widgets/man_circles.dart';
import 'package:lovemageddon/features/result/widgets/man_circles2.dart';
import 'package:lovemageddon/features/result/widgets/women_circles.dart';
import 'package:lovemageddon/features/result/widgets/women_circles2.dart';
import 'package:lovemageddon/providers/providers.dart';

class ResultScreen2 extends ConsumerStatefulWidget {
  const ResultScreen2({super.key});

  @override
  ConsumerState<ResultScreen2> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen2> {
  List<double> horizontal_position = [-0.9];
  List<double> vertical_position = [-0.8, -0.5, -0.2, 0.1, 0.4];

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    final int numberOfMember = ref.watch(numberProvider);
    final List<String> womanNameList = ref.watch(womanNameProvider);
    final List<String> manNameList = ref.watch(manNameProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          for (var i = 0; i < numberOfMember; i++)
            WomanCircles2(
              verticalPosition: vertical_position[i],
              womanName: womanNameList[i],
            ),
          for (var i = 0; i < numberOfMember; i++)
            ManCircles2(
              verticalPosition: vertical_position[i],
              manName: manNameList[i],
            ),
          Align(
            alignment: Alignment(-0.5, -0.7),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.1, 0.6),
            child: SizedBox(
              width: _screenSize.width * 0.7,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('ラブマゲドン！'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
