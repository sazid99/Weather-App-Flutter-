import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _updateTheme = ThemeMode.dark;

  ThemeMode get updateTheme {
    return _updateTheme;
  }

  toggleTheme() {
    _updateTheme =
        _updateTheme == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}