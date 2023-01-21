import 'package:flutter/material.dart';

class BeamCircles extends StatefulWidget {
  const BeamCircles({super.key});

  @override
  State<BeamCircles> createState() => _BeamCirclesState();
}

class _BeamCirclesState extends State<BeamCircles> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        left: 100,
        top: 30,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
      ),
    ]);
  }
}
