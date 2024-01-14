import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light();

  ThemeData get theme => _currentTheme;

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _currentTheme = isDarkMode ? ThemeData.dark() : ThemeData.light();
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    isDarkMode = !isDarkMode;
    prefs.setBool('isDarkMode', isDarkMode);

    _currentTheme = isDarkMode ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }
}
