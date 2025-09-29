import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easemester_app/views/pages/onboarding_page.dart';
import 'package:easemester_app/views/auth/auth_wrapper.dart';

class StartupWrapper extends StatefulWidget {
  const StartupWrapper({super.key});

  @override
  State<StartupWrapper> createState() => _StartupWrapperState();
}

class _StartupWrapperState extends State<StartupWrapper> {
  bool _loading = true;
  bool _seenOnboarding = false;

  @override
  void initState() {
    super.initState();
    _checkOnboarding();
  }

  Future<void> _checkOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool('seenOnboarding') ?? false;

    if (mounted) {
      setState(() {
        _seenOnboarding = seen;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // 👇 If onboarding already seen → go to AuthWrapper
    if (_seenOnboarding) {
      return const AuthWrapper();
    }

    // 👇 Otherwise show onboarding first
    return OnboardingPage(
      onFinish: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('seenOnboarding', true);

        if (mounted) {
          setState(() => _seenOnboarding = true);
        }
      },
    );
  }
}
