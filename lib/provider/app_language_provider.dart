import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageProvider extends ChangeNotifier {
  String appLanguage = 'en';

  AppLanguageProvider() {
    loadSavedLanguage();
  }

  Future<void> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    appLanguage = prefs.getString('app_language') ?? 'en';
    notifyListeners();
  }

  void changeLanguage(String newLanguage) async {
    if (appLanguage == newLanguage) return;

    appLanguage = newLanguage;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_language', newLanguage);

    notifyListeners();
  }
}
