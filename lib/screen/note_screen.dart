import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tood_and_note/ModelAndProvider/dialogs.dart';
import 'package:tood_and_note/widget/drawer.dart';
import 'package:tood_and_note/widget/note_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';

class NoteScreen extends StatefulWidget {
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text(
            DemoLocalizations.of(context).trans('note'),
            style: TextStyle(fontSize: 22.sp),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                size: 28.sp,
              ),
              onPressed: () {
                Provider.of<DialogsProvider>(context, listen: false)
                    .addNoteDialog(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app, size: 28.sp),
              onPressed: () {
                Future.delayed(const Duration(milliseconds: 300), () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                });
              },
            ),
          ],
        ),
        body: NoteCard());
  }
}
