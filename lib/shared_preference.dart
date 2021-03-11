import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencePage {
  static const THEME_STATUS = "THEMESTATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }

  setLang(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', value);
  }

  Future<String> getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('lang') ?? 'en';
  }
}
