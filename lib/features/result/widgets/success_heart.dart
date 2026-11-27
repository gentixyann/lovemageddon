import 'package:material_ui/material_ui.dart';

class SuccessHeart extends StatelessWidget {
  const SuccessHeart({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 0.4,
      height: screenSize.height * 0.2,
      child: Image.asset('assets/images/success.png'),
    );
  }
}
