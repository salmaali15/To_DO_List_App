
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences preferences;

  static Future<void> initSharedPref() async {
    preferences = await SharedPreferences.getInstance();
  }

  // Set The Data
  static Future<void> setData({required String key, required dynamic value}) async {
    if (value is String) {
      await preferences.setString(key, value);
    } else if (value is int) {
      await preferences.setInt(key, value);
    } else if (value is double) {
      await preferences.setDouble(key, value);
    } else {
      await preferences.setBool(key, value);
    }
  }

  // Get The Data
  static dynamic getData({required String key}) {
    return preferences.get(key);
  }
}