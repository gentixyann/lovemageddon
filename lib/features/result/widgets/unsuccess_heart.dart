import 'package:material_ui/material_ui.dart';

class UnsuccessHeart extends StatelessWidget {
  const UnsuccessHeart({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 0.47,
      height: screenSize.height * 0.22,
      child: Image.asset('assets/images/unsuccess.png'),
    );
  }
}
