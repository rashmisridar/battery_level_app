import 'package:battery_level_app/utils/theme/app_color_extension.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static final dark = ThemeData.dark().copyWith(
    textTheme: const TextTheme(
      // Define a global text style for the entire project
      bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black),
      displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      // Add more text styles as needed
    ),
    extensions: [
      _darkAppColors,
    ],
  );

  static final _darkAppColors = AppColorsExtension(
    //primary: const Color(0xffbb86fc),
    onPrimary: Colors.black,
    //  secondary: const Color(0xff03dac6),
    onSecondary: Colors.black,
    error: const Color(0xffcf6679),
    onError: Colors.black,
    background: Colors.black,//const Color(0xff121212),
    onBackground: Colors.black,
    surface: Colors.black, //const Color(0xff121212),
    onSurface: Colors.white,
  );
}