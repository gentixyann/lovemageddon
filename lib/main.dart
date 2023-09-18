import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lovemageddon/features/introduction/introduction_screen.dart';
import 'package:lovemageddon/features/start/start_screen.dart';
import 'package:lovemageddon/theme/pallete.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  // 初回起動の時でfirst_launchが存在しなければtrueになる
  bool firstLaunch = prefs.getBool('first_launch') ?? true;
  runApp(ProviderScope(
    child: MyApp(
      firstLaunch: firstLaunch,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.firstLaunch});
  final bool firstLaunch;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        primaryColor: Colors.amber[300],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Pallete.primaryColor,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        textTheme: GoogleFonts.kosugiMaruTextTheme(
          const TextTheme(
              titleLarge: TextStyle(
                fontSize: 20,
              ),
              bodyMedium: TextStyle(
                fontSize: 15,
                height: 1.5,
              ),
              bodyLarge: TextStyle(
                fontSize: 18,
                height: 1.5,
              )),
        ),
      ),
      home: firstLaunch ? const IntroductionScreen() : const StartScreen(),
    );
  }
}
