import 'package:flutter/material.dart';

class CustomTheme with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  get themeMode => _themeMode;
  toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

ThemeData _baseTheme = ThemeData(
  scrollbarTheme: ScrollbarThemeData(
      thumbVisibility: WidgetStateProperty.all<bool>(true),
      thumbColor: WidgetStateProperty.all<Color>(Colors.transparent)),

);

ThemeData darkTheme = _baseTheme.copyWith(
  brightness: Brightness.dark,
  
);

ThemeData lightTheme = _baseTheme.copyWith(
  brightness: Brightness.light,
 
);
