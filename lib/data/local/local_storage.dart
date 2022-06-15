import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  writeData({required String key, required String value}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
    preferences.reload();
  }

  Future<String?> read(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.reload();
    return preferences.getString(key);
  }

  static writeBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
    prefs.reload();
  }

  static Future<bool?> readBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
    return prefs.getBool(key);
  }
}
