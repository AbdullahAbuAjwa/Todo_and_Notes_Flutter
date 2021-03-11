import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tood_and_note/ModelAndProvider/dialogs.dart';
import 'package:tood_and_note/widget/drawer.dart';
import 'package:tood_and_note/widget/todo_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../main.dart';

class TODOScreen extends StatefulWidget {
  @override
  _TODOScreenState createState() => _TODOScreenState();
}

class _TODOScreenState extends State<TODOScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: todoAppBar(),
      body: TodoCard(),
    );
  }

  AppBar todoAppBar() {
    return AppBar(
      title: Text(
        DemoLocalizations.of(context).trans('todo'),
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
                .addTodoDialog(context);
          },
        ),
        IconButton(
          icon: Icon(
            Icons.exit_to_app,
            size: 28.sp,
          ),
          onPressed: () {
            Future.delayed(const Duration(milliseconds: 300), () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            });
          },
        ),
      ],
    );
  }
}
