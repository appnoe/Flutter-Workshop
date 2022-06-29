import 'package:flutter/material.dart';

class PSColors {
  PSColors._();
  static const Color darkgrey = Color(0xFF1E2630);
  static const Color accent = Color(0xFFFF6B6B);
  static const Color lightgrey = Color(0xFF384353);
  static const Color mediumgrey = Color(0xFF282F3A);
  static const Color extraLightGrey = Color(0xFFD3DDE9);
  static const Color rightGreen = Color(0xFF62FFBC);
}

class PSFonts {
  PSFonts._();
  static const String primaryFont = 'Inter';
}

class PSTextStyles {
  PSTextStyles._();

  // BLACK
  static const TextStyle blackRegular14 = TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontFamily: 'Inter',
  );
  // GREY
  static TextStyle halfGreyRegular12 = TextStyle(
    fontSize: 12,
    color: Colors.grey.withAlpha(128),
    fontFamily: 'Inter',
  );
}