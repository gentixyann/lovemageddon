import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovemageddon/features/final/final_screen.dart';
import 'package:lovemageddon/features/result/widgets/man_circles.dart';
import 'package:lovemageddon/features/result/widgets/success_heart.dart';
import 'package:lovemageddon/features/result/widgets/unsuccess_heart.dart';
import 'package:lovemageddon/features/result/widgets/women_circles.dart';
import 'package:lovemageddon/providers/providers.dart';
import 'dart:async';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
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
  bool _inProgress = false;

  List<double> createdVerticalPosition = [0.0, 0.0, 0.0, 0.0, 0.0];

  void createPosition(int numberOfMember) {
    final Map<int, int?> womanSelectedIntList =
        ref.watch(womanSelectedIntProvider);
    final Map<int, int?> manSelectedIntList = ref.watch(manSelectedIntProvider);
    final int numberOfMember = ref.watch(numberProvider);

    final lastNum = numberOfMember - 1;

    if (_womenTurn) {
      print('_startCounterです$_startCounter');
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
      checkSuccess(targetInt, manSelectedIntList, numberOfMember);
    } else {
      if (_isFirst) {
        _startCounter = 0;
        print('_startCounterです$_startCounter');
        // 男性側からスタートするためにX軸のListの順番を逆にする
        final reversedPosition = connectHorizontalPosition.reversed.toList();
        connectHorizontalPosition.replaceRange(
            0, connectHorizontalPosition.length, reversedPosition);
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
      checkSuccess(targetInt, womanSelectedIntList, numberOfMember);
      if (_startCounter == lastNum) {
        _isFinished = true;
      }
    }
  }

  void checkSuccess(
      int targetInt, Map<int, int?> manSelectedIntList, int numberOfMember) {
    final targetSelectedInt = manSelectedIntList[targetInt];
    Future.delayed(const Duration(seconds: 5), () {
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
      setState(() {
        _inProgress = false;
      });
    });
  }

  void decidePosition(int numberOfMember) {
    setState(() {
      _isSuccess = false;
      _isUnsuccess = false;
      _inProgress = true;
    });
    createPosition(numberOfMember);
    reset();
    createCircles(numberOfMember);
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

  void _moveStep(BuildContext ctx) {
    Navigator.pushReplacement(
        ctx, MaterialPageRoute(builder: (ctx) => const FinalScreen()));
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
            WomanCircles(
              verticalPosition: vertical_position[i],
              womanName: womanNameList[i],
            ),
          for (var i = 0; i < numberOfMember; i++)
            ManCircles(
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
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 125, 125, 125),
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
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 125, 125, 125),
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
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 125, 125, 125),
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
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 125, 125, 125),
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
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 125, 125, 125),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.1, 0.6),
            child: SizedBox(
              width: _screenSize.width * 0.7,
              child: _isFinished
                  ? ElevatedButton(
                      onPressed: _inProgress ? null : () => _moveStep(context),
                      child: const Text('次へ'),
                    )
                  : ElevatedButton(
                      onPressed: _inProgress
                          ? null
                          : () => decidePosition(numberOfMember),
                      child: const Text('モテマゲドン！'),
                    ),
            ),
          ),
          Visibility(
            visible: _isSuccess,
            child: const Align(
              alignment: Alignment(0.0, 0.0),
              child: SuccessHeart(),
            ),
          ),
          Visibility(
            visible: _isUnsuccess,
            child: const Align(
              alignment: Alignment(0.0, 0.0),
              child: UnsuccessHeart(),
            ),
          )
        ],
      ),
    );
  }
}
