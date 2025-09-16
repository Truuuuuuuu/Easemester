import 'package:easemester_app/data/notifiers.dart';
import 'package:easemester_app/views/pages/onboarding_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF011023),
              brightness: isDarkMode
                  ? Brightness.dark
                  : Brightness.light,
            ),
          ),
          home: const OnboardingPage(),
        );
      },
    );
  }
}
