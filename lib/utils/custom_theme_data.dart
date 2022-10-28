import 'package:flutter/material.dart';

const MaterialColor primarySwath = Colors.blueGrey;

class CustomThemeData {
  static ThemeData themeData = ThemeData(
    primarySwatch: primarySwath,
    textTheme:  const TextTheme(
      titleMedium: TextStyle(
            color: Colors.black87,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.2,
            fontStyle: FontStyle.normal,
          ),
      titleSmall: TextStyle(
            color: Colors.black54,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.2,
            fontStyle: FontStyle.normal,
          ),
      titleLarge:  TextStyle(
         color: Colors.black87,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
    ),
  );
}
