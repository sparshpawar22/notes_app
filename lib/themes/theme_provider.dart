import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dark_mode.dart';
import 'light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeBoxKey = 'themeBox';
  static const String _themeModeKey = 'themeMode';

  ThemeProvider() {
    _loadThemeData();
  }

  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
    _saveThemeData();
  }

  void toggleTheme() {
    themeData = isDarkMode ? lightMode : darkMode;
  }

  void _saveThemeData() async {
    var box = await Hive.openBox(_themeBoxKey);
    box.put(_themeModeKey, isDarkMode ? 'dark' : 'light');
  }

  void _loadThemeData() async {
    var box = await Hive.openBox(_themeBoxKey);
    String? theme = box.get(_themeModeKey);
    if (theme == 'dark') {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
    notifyListeners();
  }
}
