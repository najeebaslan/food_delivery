//ignore: unused_import
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperSharedPreferences {
  static SharedPreferences? _sharedPreferences;
  static const String _keyCountNotification = 'count_notification';
  // HelperSharedPreferences() {
  //   SharedPreferences.getInstance().then((value) {
  //     _sharedPreferences = value;
  //   });
  // }

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    debugPrint('SharedPreference Initialized');
  }

  ///will clear all the data stored in preference
  void clearPreferencesData() async {
    _sharedPreferences!.clear();
  }

  //this is for get string from Preferences
  static Future<String?> getString(
    String key,
  ) async {
    try {
      return _sharedPreferences?.getString(key);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  //this is for set string from Preferences
  static setString(String key, value) async {
    try {
      return _sharedPreferences?.setString(key, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //this is for set int from Preferences
  static setInt(String key, value) async {
    try {
      return _sharedPreferences?.setInt(key, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //this is for get int from Preferences
  static getInt(
    String key,
  ) async {
    try {
      return _sharedPreferences?.getInt(key);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //this is for set bool from Preferences
  static setBool(String key, value) async {
    try {
      return _sharedPreferences?.setBool(key, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //this is for get bool from Preferences
  static getBool(
    String key,
  ) async {
    try {
      return _sharedPreferences?.getBool(key);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //this is for get string from Preferences
  static deleteString(
    String key,
  ) async {
    try {
      return _sharedPreferences?.remove(key);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //this is for get string from Preferences
 static Future<bool> clear() async {
    try {
      return await _sharedPreferences!.clear();
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  Future<void> incrementCountNotification(int count) async {
    await _sharedPreferences?.setInt(_keyCountNotification, count);
  }

  static Future<void> resetCountNotification() async {
    await _sharedPreferences?.setInt(_keyCountNotification, 0);
  }

  static Future<int> getCountNotification() async {
    int count = _sharedPreferences?.getInt(_keyCountNotification) ?? 0;

    return count;
  }
}
