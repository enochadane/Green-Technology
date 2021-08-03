import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class MyTheme extends ChangeNotifier {
  static const String THEME_KEY = 'THEME_STATE';
  // SharedPreferences _themePref;
  bool _isDarkMode = false;

  MyTheme() {
    _loadThemePref();
  }

  bool get isDarkMode => _isDarkMode;

  _initThemePref() async {
    // if (_themePref == null) _themePref = await SharedPreferences.getInstance();
  }

  _loadThemePref() async {
    await _initThemePref();
    // _isDarkMode = _themePref.getBool(THEME_KEY) ?? false;
    notifyListeners();
  }

  _saveThemePref() async {
    await _initThemePref();
    // _themePref.setBool(THEME_KEY, _isDarkMode);
  }

  ThemeMode currentTheme() {
    return _isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveThemePref();
    notifyListeners();
  }
}