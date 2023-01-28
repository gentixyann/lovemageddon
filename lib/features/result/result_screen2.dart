import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovemageddon/features/result/widgets/man_circles2.dart';
import 'package:lovemageddon/features/result/widgets/success_heart.dart';
import 'package:lovemageddon/features/result/widgets/unsuccess_heart.dart';
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
  bool _womenTurn = true;
  bool _isSuccess = false;
  bool _isUnsuccess = false;
  bool _isFinished = false;

  List<double> createdVerticalPosition = [0.0, 0.0, 0.0, 0.0, 0.0];

  void createPosition(int numberOfMember) {
    final Map<int, int?> womanSelectedIntList =
        ref.watch(womanSelectedIntProvider);
    final Map<int, int?> manSelectedIntList = ref.watch(manSelectedIntProvider);
    final lastNum = numberOfMember - 1;
    print('_startCounterです$_startCounter');

    if (_womenTurn) {
      // _startCounter番目の女性が選んだ男性のindex番号を取る
      final targetInt = womanSelectedIntList[_startCounter];
      final startPos = connectVerticalPosition[_startCounter];
      final endPos = connectVerticalPosition[targetInt!];
      final centerPos = (startPos + endPos) / 2;
      final leftPos = (startPos + centerPos) / 2;
      final rightPos = (centerPos + endPos) / 2;
      createdVerticalPosition.replaceRange(0, createdVerticalPosition.length,
          [startPos, leftPos, centerPos, rightPos, endPos]);
      // マッチ成功かを判定
      checkSuccess(targetInt, manSelectedIntList);
    } else {
      if (_isFirst) {
        _startCounter = 0;
        // 男性側からスタートするためにX軸のListの順番を逆にする
        final reversedPosition = connectHorizontalPosition.reversed.toList();
        connectHorizontalPosition.replaceRange(
            0, connectHorizontalPosition.length, reversedPosition);
        print(connectHorizontalPosition);
      }
      // _startCounter番目の男性が選んだ女性のindex番号を取る
      final targetInt = manSelectedIntList[_startCounter];
      final startPos = connectVerticalPosition[_startCounter];
      final endPos = connectVerticalPosition[targetInt!];
      final centerPos = (startPos + endPos) / 2;
      final leftPos = (startPos + centerPos) / 2;
      final rightPos = (centerPos + endPos) / 2;
      createdVerticalPosition.replaceRange(0, createdVerticalPosition.length,
          [startPos, leftPos, centerPos, rightPos, endPos]);
      // マッチ成功かを判定
      checkSuccess(targetInt, womanSelectedIntList);
    }
  }

  void checkSuccess(int targetInt, Map<int, int?> manSelectedIntList) {
    final targetSelectedInt = manSelectedIntList[targetInt];
    Future.delayed(const Duration(seconds: 5), () {
      print('delayedの時点で$_startCounter');
      if (targetSelectedInt == _startCounter) {
        setState(() {
          _isSuccess = true;
        });
      } else {
        setState(() {
          _isUnsuccess = true;
        });
      }
      // 結果の表示が終わったら_startCounterをincrement
      _startCounter++;
    });
  }

  void decidePosition(int numberOfMember) {
    setState(() {
      _isSuccess = false;
      _isUnsuccess = false;
    });
    createPosition(numberOfMember);
    reset();
  }

  void reset() {
    setState(() {
      isShowCircle.replaceRange(
          0, isShowCircle.length, [false, false, false, false, false]);
    });
  }

  void createCircles(int numberOfMember) {
    // 0.7秒ごとに処理を実行
    Timer.periodic(const Duration(milliseconds: 700), (timer) {
      _timerCounter++;
      setState(() {
        isShowCircle[_timerCounter] = true;
      });
      if (_timerCounter == 4) {
        timer.cancel();
        _timerCounter = -1;
      }
    });
    final lastNum = numberOfMember - 1;
    if (_startCounter != lastNum) {
      _isFirst = false;
    } else {
      print('女性のターン終わり。次は男性');
      _isFirst = true;
      _womenTurn = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    final int numberOfMember = ref.watch(numberProvider);
    final List<String> womanNameList = ref.watch(womanNameProvider);
    final List<String> manNameList = ref.watch(manNameProvider);
    final lastNum = numberOfMember - 1;

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
              alignment: Alignment(
                  connectHorizontalPosition[0], createdVerticalPosition[0]),
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
              alignment: Alignment(
                  connectHorizontalPosition[1], createdVerticalPosition[1]),
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
              alignment: Alignment(
                  connectHorizontalPosition[2], createdVerticalPosition[2]),
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
              alignment: Alignment(
                  connectHorizontalPosition[3], createdVerticalPosition[3]),
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
              alignment: Alignment(
                  connectHorizontalPosition[4], createdVerticalPosition[4]),
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
                  createCircles(numberOfMember);
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
          Visibility(
            visible: _isSuccess,
            child: Align(
              alignment: Alignment(0.0, 0.0),
              child: SuccessHeart(),
            ),
          ),
          Visibility(
            visible: _isUnsuccess,
            child: Align(
              alignment: Alignment(0.0, 0.0),
              child: UnsuccessHeart(),
            ),
          )
        ],
      ),
    );
  }
}
