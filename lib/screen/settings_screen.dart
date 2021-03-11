import 'package:flutter/material.dart';
import 'package:tood_and_note/ModelAndProvider/language.dart';
import 'package:tood_and_note/ModelAndProvider/theme_provider.dart';
import 'package:tood_and_note/widget/drawer.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../main.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int languageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);
    final lang = Provider.of<LangProvider>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          DemoLocalizations.of(context).trans('setting'),
          style: TextStyle(fontSize: 22.sp),
        ),
      ),
      body: SettingsList(
        darkBackgroundColor: Color(0xff363434),
        sections: [
          SettingsSection(
            title: DemoLocalizations.of(context).trans('language'),
            titleTextStyle: TextStyle(color: Colors.blue[800], fontSize: 20.sp),
            titlePadding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              left: MediaQuery.of(context).padding.left + 15,
              right: MediaQuery.of(context).padding.right + 15,
            ),
            tiles: [
              SettingsTile(
                title: DemoLocalizations.of(context).trans('enLang'),
                trailing: lang.language == 'en'
                    ? Icon(Icons.check, color: Colors.blue)
                    : Icon(null),
                onPressed: (BuildContext context) {
                  changeLanguage(0);
                  lang.language = 'en';
                },
              ),
              SettingsTile(
                title: DemoLocalizations.of(context).trans('arLang'),
                trailing: lang.language == 'ar'
                    ? Icon(Icons.check, color: Colors.blue)
                    : Icon(null),
                onPressed: (BuildContext context) {
                  changeLanguage(1);
                  lang.language = 'ar';
                },
              ),
            ],
          ),
          SettingsSection(
            title: DemoLocalizations.of(context).trans('dark_mode'),
            titlePadding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              left: MediaQuery.of(context).padding.left + 15,
              right: MediaQuery.of(context).padding.right + 15,
            ),
            titleTextStyle: TextStyle(color: Colors.blue[800], fontSize: 20.sp),
            tiles: [
              SettingsTile.switchTile(
                title: DemoLocalizations.of(context).trans('enable_dark_mode'),
                titleTextStyle: TextStyle(fontSize: 18.sp),
                leading: Icon(
                  Icons.nightlight_round,
                  size: 28.sp,
                ),
                switchValue: themeChange.darkTheme,
                onToggle: (bool value) {
                  setState(() {
                    themeChange.darkTheme = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void changeLanguage(int index) {
    setState(() {
      languageIndex = index;
    });
  }
}
