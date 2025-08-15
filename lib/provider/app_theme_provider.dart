import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  AppThemeProvider() {
    loadSavedTheme();
  }

  Future<void> loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('is_dark_theme') ?? false;
    appTheme = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) return;

    appTheme = newTheme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_dark_theme', newTheme == ThemeMode.dark);

    notifyListeners();
  }
}
