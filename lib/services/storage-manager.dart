import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static Future<bool> saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    if (value is int) {
      prefs.setInt(key, value);
      return true;
    } else if (value is String) {
      prefs.setString(key, value);
      return true;
    } else if (value is bool) {
      prefs.setBool(key, value);
      return true;
    } else {
      return false;
    }
  }

  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    dynamic obj = prefs.get(key);
    return obj;
  }

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static Future<bool> deleteAll({List<String>? excepts}) async {
    final prefs = await SharedPreferences.getInstance();

    if (excepts == null) {
      return prefs.clear();
    }

    prefs.getKeys().forEach((element) {
      if (!excepts.contains(element)) {
        prefs.remove(element);
      }
    });

    return true;
  }

  static Future<void> reloadSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
  }
}
