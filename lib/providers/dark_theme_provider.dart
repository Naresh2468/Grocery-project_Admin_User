
import 'package:flutter/material.dart';
//import 'package:Gstore_Admin_Panel/services/dark_theme_preferences.dart';
import 'package:gstore_admin_panel/services/dark_them_preferences.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  bool get getDarkTheme => _darkTheme;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}