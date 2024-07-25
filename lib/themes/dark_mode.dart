import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    background: Colors.black54,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade800,
    tertiary: Colors.grey.shade600,
    surface: Colors.grey.shade800, // Add surface color for list items
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black54, // Match AppBar color with background
  ),
);