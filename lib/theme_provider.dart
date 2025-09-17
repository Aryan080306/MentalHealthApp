import 'package:flutter/material.dart';

// creates class to manage light and dark theme
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
// getter method to get the current theme
  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode; // sets the new theme
    notifyListeners();
  }
}
