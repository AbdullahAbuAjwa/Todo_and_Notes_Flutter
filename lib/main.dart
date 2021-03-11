import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:tood_and_note/ModelAndProvider/Note.dart';
import 'package:tood_and_note/ModelAndProvider/Task.dart';
import 'package:tood_and_note/screen/note_details_screen.dart';
import 'package:tood_and_note/screen/splash_screen.dart';
import 'package:tood_and_note/screen/tasks_of_todo_screen.dart';
import 'package:provider/provider.dart';
import 'ModelAndProvider/Todo.dart';
import 'ModelAndProvider/dialogs.dart';
import 'ModelAndProvider/language.dart';
import 'ModelAndProvider/theme_provider.dart';

class DemoLocalizations {
  DemoLocalizations(this.locale);

  final Locale locale;

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  Map<String, String> _sentences;

  Future<bool> load() async {
    String data =
        await rootBundle.loadString('lang/${this.locale.languageCode}.json');
    Map<String, dynamic> _result = json.decode(data);

    this._sentences = new Map();
    _result.forEach((String key, dynamic value) {
      this._sentences[key] = value.toString();
    });

    return true;
  }

  String trans(String key) {
    return this._sentences[key];
  }
}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['ar', 'en'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) async {
    DemoLocalizations localizations = new DemoLocalizations(locale);
    await localizations.load();

    return localizations;
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeChangeProvider = ThemeProvider();
  LangProvider langProvider = LangProvider();

  @override
  void initState() {
    getCurrentAppTheme();
    getCurrentLang();
    super.initState();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  void getCurrentLang() async {
    langProvider.language = await langProvider.langPreference.getLang();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: NoteProvider()),
        ChangeNotifierProvider.value(value: Note()),
        ChangeNotifierProvider.value(value: TodoProvider()),
        ChangeNotifierProvider.value(value: TaskProvider()),
        ChangeNotifierProvider.value(value: themeChangeProvider),
        ChangeNotifierProvider.value(value: langProvider),
        ChangeNotifierProvider.value(value: DialogsProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return ScreenUtilInit(
            builder: () =>
                //child:
                MaterialApp(
              debugShowCheckedModeBanner: false,
              supportedLocales: [
                const Locale('ar', ''),
                const Locale('en', ''),
              ],
              locale: Provider.of<LangProvider>(context).locale(context, 'en'),
              localizationsDelegates: [
                const DemoLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              localeResolutionCallback:
                  (Locale locale, Iterable<Locale> supportedLocales) {
                for (Locale supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale.languageCode ||
                      supportedLocale.countryCode == locale.countryCode) {
                    return supportedLocale;
                  }
                }

                return supportedLocales.first;
              },
              title: 'Note and Todo',
              theme: Provider.of<ThemeProvider>(context).themeData(context),
              home: SplashScreen(),
              routes: {
                'move_to_note_details': (ctx) => NoteDetailsScreen(),
                'move_to_todo_details': (ctx) => TasksOfTodoScreen(),
              },
            ),
          );
        },
        //  child:
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}
