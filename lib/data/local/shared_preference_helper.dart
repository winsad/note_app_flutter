import 'package:flutter/material.dart';
import 'package:note_app/helpers/utils/extensions.dart';
import 'package:note_app/helpers/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  const SharedPreferenceHelper(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  bool get isFirstLogin => _sharedPreferences.getBool('isFirstLogin') ?? true;
  Future<bool> saveIsFirstLogin(bool value) {
    return _sharedPreferences.setBool('isFirstLogin', value);
  }

  ThemeMode get themeMode =>
      getThemeFromString(_sharedPreferences.getString('themeMode') ?? '');
  Future<bool> saveThemeMode(ThemeMode theme) {
    return _sharedPreferences.setString('themeMode', theme.getValueString);
  }

  bool get isDarkMode => _sharedPreferences.getBool('isDarkMode') ?? false;
  Future<bool> saveIsDarkMode(bool value) {
    return _sharedPreferences.setBool('isDarkMode', value);
  }

  String get getNotes => _sharedPreferences.getString('notes') ?? '';
  Future<bool> saveNotes(String value) {
    return _sharedPreferences.setString('notes', value);
  }
}
