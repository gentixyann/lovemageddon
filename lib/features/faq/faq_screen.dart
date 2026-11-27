import 'package:flutter/gestures.dart';
import 'package:material_ui/material_ui.dart';
import 'package:lovemageddon/theme/pallete.dart';
import 'package:url_launcher/url_launcher.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SelectionArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'よくある質問など！',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: screenSize.width * 0.6,
                    decoration: BoxDecoration(
                      color: Pallete.primaryPaleColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                      '女男で別々の人数なんですけど！！🥺',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: screenSize.width * 0.6,
                    decoration: BoxDecoration(
                      color: Pallete.secondaryPaleColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: 'もっと自由度が高い'),
                          TextSpan(
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue,
                            ),
                            text: "web版",
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () async {
                                    final uri = Uri.parse(
                                      "https://0414.works/couple/",
                                    );
                                    launchUrl(uri);
                                  },
                          ),
                          const TextSpan(text: 'ならできます！制作者はアシンメトリーの友達です😇'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: screenSize.width * 0.6,
                    decoration: BoxDecoration(
                      color: Pallete.primaryPaleColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                      '不具合とか要望とか、色々と言いたいことあるんですけど！！😊',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: screenSize.width * 0.6,
                    decoration: BoxDecoration(
                      color: Pallete.secondaryPaleColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue,
                            ),
                            text: "ここのフォーム",
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () async {
                                    final uri = Uri.parse(
                                      "https://docs.google.com/forms/d/e/1FAIpQLSdVLxLJFA8MWr2pBX92Aq0zujjVVkrSXUiq3TRIaPkJi_IhMQ/viewform",
                                    );
                                    launchUrl(uri);
                                  },
                          ),
                          const TextSpan(text: 'から送るときっと開発者の元に届くはず！（いずれは）'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
