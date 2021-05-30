import 'package:shared_preferences/shared_preferences.dart';

class LocalSharedPreference {
  final SharedPreferences _preferences;
  LocalSharedPreference(this._preferences);

  Future<bool> setString(String key, String value) {
    return _preferences.setString(key, value);
  }

  String getString(String key) {
    return _preferences.getString(key);
  }
}
