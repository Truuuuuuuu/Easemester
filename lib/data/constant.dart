import 'package:flutter/material.dart';

//fontstyle
class AppFonts {
  static const String fontFamily = 'Poppins';
  //for titles
  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w900,
    color: Colors.black,
  );
  //headin1
  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );
  //headin2
  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );
  //headin3
  static const TextStyle heading3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );
  //paragraph
  static const TextStyle paragraph = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black54,
  );
}

class AppColor {
  static const Color whiteBackground = Color(0xFFF6FAFD);
}
