import 'package:shared_preferences/shared_preferences.dart';

class Application {
  factory Application() {
    return _instance;
  }
  Application._internal();

  static final Application _instance = Application._internal();

  static late SharedPreferences preferences;
  static Future<void> setPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  static void setToken(String token) => preferences.setString('token', token);
  static String? getToken() => preferences.getString('token');
  static void removeToken() => preferences.remove('token');
}
