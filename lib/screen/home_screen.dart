import 'package:flip_box_bar_plus/flip_box_bar_plus.dart';
import 'package:flutter/material.dart';
import 'package:tood_and_note/ModelAndProvider/theme_provider.dart';
import 'package:tood_and_note/screen/note_screen.dart';
import 'package:tood_and_note/screen/todo_screen.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navigationBar(),
      body: selectedIndex == 0 ? TODOScreen() : NoteScreen(),
    );
  }

  Widget navigationBar() {
    return FlipBoxBarPlus(
      selectedIndex: selectedIndex,
      items: [
        FlipBarItem(
          icon: const Icon(Icons.today_outlined),
          text: Text(DemoLocalizations.of(context).trans('todo')),
          frontColor: Provider.of<ThemeProvider>(context).darkTheme
              ? Color(0xff423e3e)
              : Theme.of(context).accentColor,
          backColor: Provider.of<ThemeProvider>(context).darkTheme
              ? Color(0xff121212)
              : Theme.of(context).primaryColor,
        ),
        FlipBarItem(
          icon: const Icon(Icons.note_sharp),
          text: Text(DemoLocalizations.of(context).trans('note')),
          frontColor: Provider.of<ThemeProvider>(context).darkTheme
              ? Color(0xff423e3e)
              : Theme.of(context).accentColor,
          backColor: Provider.of<ThemeProvider>(context).darkTheme
              ? Color(0xff121212)
              : Theme.of(context).primaryColor,
        ),
      ],
      onIndexChanged: (newIndex) {
        setState(() {
          selectedIndex = newIndex;
        });
      },
    );
  }
}
