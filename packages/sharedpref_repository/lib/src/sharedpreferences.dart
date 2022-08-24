import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  final SharedPreferences _sharedPreferences;
  AppSharedPref(this._sharedPreferences);

  final String _isLogin = "isLogin";

  Future<bool?> isLogin() async {
    try {
      return _sharedPreferences.getBool(_isLogin);
    } catch (e) {
      return false;
    }
  }

  Future<void> setLogin(bool value) async {
    try {
      await _sharedPreferences.setBool(_isLogin, value);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
