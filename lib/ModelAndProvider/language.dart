import 'package:flutter/cupertino.dart';

import '../shared_preference.dart';

class LangProvider with ChangeNotifier {
  SharedPreferencePage langPreference = SharedPreferencePage();

  String _language;

  String get language => _language;

  set language(value) {
    _language = value;
    langPreference.setLang(value);
    notifyListeners();
  }

  Locale locale(BuildContext context, deviceLang) {
    return Locale(_language ?? deviceLang);
  }

  String deviceLang(BuildContext context) {
    return Localizations.localeOf(context).toString();
  }
//todo : device language as default
}
