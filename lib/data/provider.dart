import 'package:fit_track/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final nameProvider =
    ChangeNotifierProvider<NameNotifier>((ref) => NameNotifier());

class NameNotifier extends ChangeNotifier {
  String name = '';

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }
}




final themeProvider = StateNotifierProvider<ThemeProvider, ThemeData>((ref) {
  return ThemeProvider();
});

class ThemeProvider extends StateNotifier<ThemeData> {
  ThemeProvider() : super(lightTheme) { // Default to lightTheme
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark') ?? false;
    state = isDark ? darkTheme : lightTheme;
  }

  void toggleTheme(bool isDark) async {
    state = isDark ? darkTheme : lightTheme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
  }
}