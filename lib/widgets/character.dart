import 'package:material_ui/material_ui.dart';

class Character extends StatelessWidget {
  final int num;
  const Character({super.key, required this.num});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/character$num.png');
  }
}
