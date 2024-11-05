import 'package:homecredit/utils/log.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences 
class SpUtil {

  /// 
  static put(String key, Object value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is List<String>) {
      prefs.setStringList(key, value);
    } else {
      prefs.setString(key, value.toString());
    }
  }

  /// Object
  static Future<Object?> get(String key, [Object? defaultValue]) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.get(key) ?? defaultValue;
  }

  /// String
  static Future<String> getString(String key, [String defaultValue = ""]) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(key) ?? defaultValue;
  }

  ///  List<String>
  static Future<List<String>?> getStringList(String key, [List<String>? defaultValue]) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getStringList(key) ?? defaultValue;
  }

  ///  int
  static Future<int> getInt(String key, [int defaultValue = 0]) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getInt(key) ?? defaultValue;
  }

  ///  double
  static Future<double> getDouble(String key, [double defaultValue = 0.0]) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getDouble(key) ?? defaultValue;
  }

  ///  bool
  static Future<bool> getBool(String key, [bool defaultValue = false]) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getBool(key) ?? defaultValue;
  }

  /// 
  static remove(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  /// 
  static clear(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
