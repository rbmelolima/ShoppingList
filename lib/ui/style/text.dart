import 'package:flutter/material.dart';

TextStyle _title(Color? color, double fontSize) {
  return TextStyle(
    fontFamily: "Open Sans",
    fontWeight: FontWeight.w700,
    fontSize: fontSize,
    color: color,
  );
}

class AppText {
  static TextStyle h1(Color? color) => _title(color, 48);
  static TextStyle h2(Color? color) => _title(color, 40);
  static TextStyle h3(Color? color) => _title(color, 32);
  static TextStyle h4(Color? color) => _title(color, 24);
  static TextStyle h5(Color? color) => _title(color, 18);

  /// Style for paragraphs
  static TextStyle p(Color? color, [double fontSize = 16]) {
    return TextStyle(
      fontFamily: "PT Sans",
      fontWeight: FontWeight.w400,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle input(Color? color) {
    return TextStyle(
      fontFamily: "PT Sans",
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: color,
    );
  }

  /// Style for buttons
  static TextStyle btn(Color? color) {
    return TextStyle(
      fontFamily: "Open Sans",
      fontWeight: FontWeight.w700,
      letterSpacing: 0.8,
      fontSize: 16,
      color: color,
    );
  }

  static TextStyle chip(Color? color) {
    return TextStyle(
      fontFamily: "Open Sans",
      fontWeight: FontWeight.w600,
      letterSpacing: 0.8,
      fontSize: 12,
      color: color,
    );
  }

  static TextStyle popup(Color? color) {
    return TextStyle(
      fontFamily: "Open Sans",
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: color,
    );
  }
}
