import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  final SharedPreferences _sharedPreferences;
  AppSharedPref(this._sharedPreferences);

  final String _isLogin = "isLogin";
  final String _isAdmin = "isAdmin";
  final String _isSuperAdmin = "isAdmin";
  final String _merchantId = "merchantId";
  final String _progress = "progress";
  final String _lat = 'lat';
  final String _long = 'long';
  Future<double?> getProgress() async {
    try {
      return _sharedPreferences.getDouble(_progress);
    } catch (e) {
      return 0;
    }
  }

  Future<String?> getLat() async {
    try {
      return _sharedPreferences.getString(_lat);
    } catch (e) {
      return "";
    }
  }

  Future<String?> getLong() async {
    try {
      return _sharedPreferences.getString(_long);
    } catch (e) {
      return "";
    }
  }

  Future<void> setProgress(double value) async {
    try {
      await _sharedPreferences.setDouble(_progress, value);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> setLong(String value) async {
    try {
      await _sharedPreferences.setString(_long, value);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> setLat(String value) async {
    try {
      await _sharedPreferences.setString(_lat, value);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

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

  Future<bool?> isAdmin() async {
    try {
      return _sharedPreferences.getBool(_isAdmin);
    } catch (e) {
      return false;
    }
  }

  Future<void> setAdmin(bool value) async {
    try {
      await _sharedPreferences.setBool(_isAdmin, value);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<bool?> isSuperAdmin() async {
    try {
      return _sharedPreferences.getBool(_isSuperAdmin);
    } catch (e) {
      return false;
    }
  }

  Future<void> setSuperAdmin(bool value) async {
    try {
      await _sharedPreferences.setBool(_isSuperAdmin, value);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> setMerchantId(String value) async {
    try {
      await _sharedPreferences.setString(_merchantId, value);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<String?> getMerchantId() async {
    try {
      return _sharedPreferences.getString(_merchantId);
    } catch (e) {
      return null;
    }
  }
}
