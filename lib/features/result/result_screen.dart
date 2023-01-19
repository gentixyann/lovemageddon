import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovemageddon/features/result/widgets/man_circles.dart';
import 'package:lovemageddon/features/result/widgets/women_circles.dart';
import 'package:lovemageddon/providers/providers.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    final int numberOfMember = ref.watch(numberProvider);
    final List<String> womanNameList = ref.watch(womanNameProvider);
    final List<String> manNameList = ref.watch(manNameProvider);

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(2),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          WomanCircles(),
          ManCircles(),
        ],
      ),
    ));
  }
}
