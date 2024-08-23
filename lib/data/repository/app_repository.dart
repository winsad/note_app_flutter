import 'package:flutter/material.dart';
import 'package:note_app/data/local/shared_preference_helper.dart';

abstract class AppRepository {
  bool get isFirstLogin;

  bool get isDarkMode;

  ThemeMode get themeMode;

  Future<bool> saveThemeMode(ThemeMode theme);

  Future<bool> saveIsFirstLogin(bool value);
}

class AppRepositoryImpl implements AppRepository {
  AppRepositoryImpl(this._sharedPreferenceHelper);

  final SharedPreferenceHelper _sharedPreferenceHelper;

  @override
  bool get isFirstLogin => _sharedPreferenceHelper.isFirstLogin;

  @override
  bool get isDarkMode => _sharedPreferenceHelper.isDarkMode;

  @override
  Future<bool> saveThemeMode(ThemeMode value) {
    return _sharedPreferenceHelper.saveThemeMode(value);
  }

  @override
  ThemeMode get themeMode => _sharedPreferenceHelper.themeMode;

  @override
  Future<bool> saveIsFirstLogin(bool value) {
    return _sharedPreferenceHelper.saveIsFirstLogin(value);
  }
}
