import 'package:flutter/material.dart';
import 'package:tood_and_note/ModelAndProvider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteDetails extends StatelessWidget {
  final title;
  final text;
  final time;

  NoteDetails(this.title, this.text, this.time);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);

    return Container(
      child: Card(
        margin: EdgeInsets.all(0),
        elevation: 0,
        color: themeChange.darkTheme ? Color(0xff2b2a2a) : Colors.white,
        child: ListTile(
          title: Text(
            time,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.sp),
          ),
          subtitle: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top + 30),
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp),
            ),
          ),
        ),
      ),
    );
  }
}
