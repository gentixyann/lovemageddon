import 'package:flutter/material.dart';

class NextFloatingActionButton extends StatelessWidget {
  const NextFloatingActionButton({super.key, required this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.arrow_right_alt),
    );
  }
}
