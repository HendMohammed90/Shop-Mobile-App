import 'package:shared_preferences/shared_preferences.dart';

class CacheWrapper {
  static SharedPreferences? prefs;

  static init() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> putUserMoode(
      {required String key, required bool value}) async {
    return await prefs!.setBool(key, value);
  }

  static getUserMode({required key}) {
    return prefs!.getBool(key);
  }

  static dynamic getData({required String key}) {
    return prefs!.get(key);
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) return await prefs!.setString(key, value);
    if (value is bool) return await prefs!.setBool(key, value);
    if (value is int) return await prefs!.setInt(key, value);
    return await prefs!.setDouble(key, value);
  }

  static Future<bool> clearData() async {
    return await prefs!.remove('token');
  }
}
