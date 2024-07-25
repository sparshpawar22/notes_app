import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    tertiary: Colors.white,
    surface: Colors.white, // Add surface color for list items
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade200, // Match AppBar color with background
  ),
);