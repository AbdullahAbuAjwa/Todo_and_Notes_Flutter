import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tood_and_note/widget/drawer.dart';
import 'package:tood_and_note/widget/note_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text(
            DemoLocalizations.of(context).trans('fav_notes'),
            style: TextStyle(fontSize: 22.sp),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                size: 25.sp,
              ),
              onPressed: () {
                Future.delayed(const Duration(milliseconds: 300), () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                });
              },
            ),
          ],
        ),
        body: NoteFavCard());
  }
}
