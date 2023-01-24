import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovemageddon/features/result/widgets/beam_circles.dart';
import 'package:lovemageddon/features/result/widgets/man_circles.dart';
import 'package:lovemageddon/features/result/widgets/man_circles2.dart';
import 'package:lovemageddon/features/result/widgets/women_circles.dart';
import 'package:lovemageddon/features/result/widgets/women_circles2.dart';
import 'package:lovemageddon/providers/providers.dart';
import 'dart:async';

class ResultScreen2 extends ConsumerStatefulWidget {
  const ResultScreen2({super.key});

  @override
  ConsumerState<ResultScreen2> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen2> {
  // 始点の縦軸（Y）のポジション
  List<double> vertical_position = [-0.8, -0.5, -0.2, 0.1, 0.4];
  // 繋げるマルの横軸（X）のポジション
  List<double> connectHorizontalPosition = [-0.6, -0.3, 0.0, 0.3, 0.6];
  // 繋げるマルの始点の縦軸（Y）のポジション
  List<double> connectVerticalPosition = [-0.78, -0.5, -0.22, 0.07, 0.36];
  // １秒毎にsetStateを実行するためのcounter
  int _timerCounter = -1;
  // 始点となるマルが何番目かを表すcounter
  int _startCounter = 0;
  List<bool> isShowCircle = [false, false, false, false, false];
  bool _isFirst = true;

  List<double> createdVerticalPosition = [0.0, 0.0, 0.0, 0.0, 0.0];

  void createPosition(int numberOfMember) {
    final Map<int, int?> womanSelectedIntList =
        ref.watch(womanSelectedIntProvider);
    // print(womanSelectedIntList);
    final lastNum = numberOfMember - 1;
    if (_startCounter == lastNum || _isFirst) {
      _startCounter = 0;
    } else {
      _startCounter++;
    }
    // _startCounter番目の女性が選んだ男性のindex番号を取る
    final targetInt = womanSelectedIntList[_startCounter];

    final startPos = connectVerticalPosition[_startCounter];
    final endPos = connectVerticalPosition[targetInt!];

    final centerPos = (startPos + endPos) / 2;
    final leftPos = (startPos + centerPos) / 2;
    final rightPos = (centerPos + endPos) / 2;
    createdVerticalPosition.replaceRange(0, createdVerticalPosition.length,
        [startPos, leftPos, centerPos, rightPos, endPos]);
    print(createdVerticalPosition);
    _isFirst = false;
  }

  void decidePosition(int numberOfMember) {
    createPosition(numberOfMember);

    print('_startCounterです$_startCounter');

    reset();
  }

  void createCircles() {
    Timer.periodic(const Duration(milliseconds: 700), (timer) {
      _timerCounter++;
      // print(_timerCounter);
      setState(() {
        isShowCircle[_timerCounter] = true;
      });
      if (_timerCounter == 4) {
        timer.cancel();
        _timerCounter = -1;
        // print('ストップです');
      }
    });
  }

  void reset() {
    setState(() {
      isShowCircle.replaceRange(
          0, isShowCircle.length, [false, false, false, false, false]);
    });
    // _isFirst = true;
  }

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
          Visibility(
            visible: isShowCircle[0],
            child: Align(
              alignment: Alignment(-0.6, createdVerticalPosition[0]),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Visibility(
            visible: isShowCircle[1],
            child: Align(
              alignment: Alignment(-0.3, createdVerticalPosition[1]),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Visibility(
            visible: isShowCircle[2],
            child: Align(
              alignment: Alignment(0.0, createdVerticalPosition[2]),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Visibility(
            visible: isShowCircle[3],
            child: Align(
              alignment: Alignment(0.3, createdVerticalPosition[3]),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Visibility(
            visible: isShowCircle[4],
            child: Align(
              alignment: Alignment(0.6, createdVerticalPosition[4]),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.1, 0.6),
            child: SizedBox(
              width: _screenSize.width * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  decidePosition(numberOfMember);
                  createCircles();
                  // _startCounter++;
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('ラブマゲドン！'),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.1, 0.9),
            child: SizedBox(
              width: _screenSize.width * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  reset();
                  // createPosition();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('リセット'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
