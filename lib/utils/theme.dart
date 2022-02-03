import 'package:flutter/material.dart';

class DefaultTheme {
  bool isDarkMode(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }

  Color? coinCardColor;

  DefaultTheme(BuildContext context) {
    coinCardColor = (isDarkMode(context)) ? null : const Color(0xfff5f5f5);
  }
}
