import 'package:flutter/material.dart';
import 'package:tood_and_note/shared_preference.dart';

class ThemeProvider with ChangeNotifier {
  SharedPreferencePage darkThemePreference = SharedPreferencePage();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }

  ThemeData themeData(BuildContext context) {
    return ThemeData(
      primaryColor: _darkTheme ? Color(0xFF212121) : Colors.orangeAccent,
      accentColor: _darkTheme ? Color(0xff0040a6) : Colors.deepOrangeAccent,
      backgroundColor: _darkTheme ? Colors.black : Color(0xffF1F5FB),
      indicatorColor: _darkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      hintColor: _darkTheme ? Colors.grey[100] : Colors.grey,
      hoverColor: _darkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      focusColor: _darkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: _darkTheme ? Colors.grey[600] : Color(0xFFffcd3c),
      brightness: _darkTheme ? Brightness.dark : Brightness.light,
    );
  }
}
