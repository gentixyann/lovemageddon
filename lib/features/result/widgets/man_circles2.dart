import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lovemageddon/providers/providers.dart';

class ManCircles2 extends ConsumerWidget {
  final double verticalPosition;
  final String manName;
  const ManCircles2(
      {super.key, required this.verticalPosition, required this.manName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _screenSize = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment(0.9, verticalPosition),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
          Text(manName),
        ],
      ),
    );
    ;
  }
}
