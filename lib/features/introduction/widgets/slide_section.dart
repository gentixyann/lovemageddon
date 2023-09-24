import 'package:flutter/material.dart';

class SlideSection extends StatelessWidget {
  const SlideSection({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
  }) : super(key: key);

  final String title;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: deviceHeight * 0.15,
            bottom: deviceHeight * 0.05,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: deviceHeight * 0.35,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(image),
              )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.6,
            ),
          ),
        ),
        Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
