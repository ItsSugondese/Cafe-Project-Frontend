import 'package:shared_preferences/shared_preferences.dart';

class StoreService {
  static const String _rolesKey = "ROLES";
  static const String _passwordKey = "PASSWORD";

  static Future<void> setRoles(String role) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_rolesKey, role);
  }

  static Future<void> setPassword(String password) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_passwordKey, password);
  }

  static Future<String?> getRole() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_rolesKey);
  }

  static Future<String?> getPassword() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_passwordKey);
  }

  static Future<void> clear() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
