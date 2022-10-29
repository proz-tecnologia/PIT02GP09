import 'package:flutter/material.dart';

const MaterialColor primarySwath = Colors.blueGrey;

class CustomThemeData {
  static ThemeData themeData = ThemeData(
    primarySwatch: primarySwath,
    backgroundColor: const Color(0xFFFFFFFF),
    textTheme: TextTheme(
      titleMedium: const TextStyle(
        color: Colors.black87,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.2,
        fontStyle: FontStyle.normal,
      ),
      titleSmall: const TextStyle(
        color: Colors.black54,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.2,
        fontStyle: FontStyle.normal,
      ),
      titleLarge: const TextStyle(
        color: Colors.black87,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: TextStyle(
        fontSize: 16,
        color: Colors.grey[700],
      ),
    ),
  );
}
