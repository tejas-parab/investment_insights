import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
    fontFamily: 'Roboto',
    cardTheme: const CardThemeData(
      elevation: 6,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
    ),
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardTheme: const CardThemeData(
      elevation: 8,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
    ),
  );
}
