import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthService {
  static late SharedPreferences prefs;
  static String key = "userNameKey";

  static initService() async {
    prefs = await SharedPreferences.getInstance();
  }

  static login(String name) async {
    await prefs.setString(key, name);
  }

  static signup(String name) async {
    await prefs.setString(key, name);
  }
}
