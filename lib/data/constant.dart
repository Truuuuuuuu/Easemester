import 'package:flutter/material.dart';
import '../data/notifiers.dart'; 

class KMainColor {
  KMainColor._(); // private constructor

  // Light mode colors
  static const Color _darkBlue = Color(0xFF011023); // icons
  static const Color _whiteText = Color(0xFFF6FAFD); // text
  static const Color _whiteScreen = Color(0xFFF5F5F5); // backgrounds

  // Dark mode variants (adjust for readability)
  static const Color _darkBlueDark = Color(0xFF011023); // keep same
  static const Color _whiteTextDark = Color(0xFFF6FAFD); // keep same
  static const Color _whiteScreenDark = Color(0xFF121212); // dark background

  // Getters that adapt to dark mode
  static Color get icon => isDarkModeNotifier.value ? _darkBlueDark : _darkBlue;
  static Color get text => isDarkModeNotifier.value ? _whiteTextDark : _whiteText;
  static Color get background => isDarkModeNotifier.value ? _whiteScreenDark : _whiteScreen;
}
