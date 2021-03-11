import 'package:flutter/material.dart';
import 'package:tood_and_note/ModelAndProvider/theme_provider.dart';
import 'package:tood_and_note/screen/contact_screen.dart';
import 'package:tood_and_note/screen/favorites_screen.dart';
import 'package:tood_and_note/screen/home_screen.dart';
import 'package:tood_and_note/screen/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../main.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            color: Provider.of<ThemeProvider>(context).darkTheme
                ? Color(0xff006494)
                : Colors.orangeAccent,
          ),
          DrawerTile(
            title: DemoLocalizations.of(context).trans('home'),
            icon: Icons.home,
            color: getIconColor(),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) {
                return HomeScreen();
              }));
            },
          ),
          DrawerTile(
            title: DemoLocalizations.of(context).trans('favorites'),
            icon: Icons.favorite,
            color: Colors.red,
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) {
                return FavoriteScreen();
              }));
            },
          ),
          DrawerTile(
            title: DemoLocalizations.of(context).trans('setting'),
            icon: Icons.settings,
            color: getIconColor(),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) {
                  return SettingsScreen();
                },
              ));
            },
          ),
          DrawerTile(
            title: DemoLocalizations.of(context).trans('contact'),
            icon: Icons.contact_mail,
            color: getIconColor(),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) {
                  return ContactScreen();
                },
              ));
            },
          ),
          DrawerTile(
            title: DemoLocalizations.of(context).trans('share'),
            icon: Icons.share,
            color: getIconColor(),
            onTap: () {
              final RenderBox box = context.findRenderObject();
              Share.share('Try this app: https://play.google.com/store/apps',
                  sharePositionOrigin:
                      box.localToGlobal(Offset.zero) & box.size);
            },
          ),
          DrawerTile(
            title: DemoLocalizations.of(context).trans('rating'),
            icon: Icons.star,
            color: getIconColor(),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Color getIconColor() {
    Color iconColor;
    Provider.of<ThemeProvider>(context).darkTheme
        ? iconColor = Colors.blue
        : iconColor = Colors.black;
    return iconColor;
  }
}

class DrawerTile extends StatefulWidget {
  final title;
  final icon;
  final color;
  final Function onTap;

  const DrawerTile({
    Key key,
    this.title,
    this.icon,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  _DrawerTileState createState() => _DrawerTileState();
}

class _DrawerTileState extends State<DrawerTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        title: Text(widget.title),
        leading: Icon(widget.icon, color: widget.color),
      ),
      onTap: widget.onTap,
    );
  }
}
