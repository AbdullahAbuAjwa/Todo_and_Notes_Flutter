import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../main.dart';
import 'Note.dart';
import 'Todo.dart';
import 'Task.dart';

class DialogsProvider with ChangeNotifier {
  var currentColor = Color(0xffff4545);

  Future<void> addTodoDialog(BuildContext context) {
    final _titleController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              DemoLocalizations.of(context).trans('add_todo'),
              style: TextStyle(fontSize: 20.sp),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _titleController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return DemoLocalizations.of(context)
                            .trans('please_enter_title');
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText:
                          DemoLocalizations.of(context).trans('enter_title'),
                      hintText: DemoLocalizations.of(context).trans('title'),
                    ),
                  ),
                ),
                SizedBox(height: 16.sp),
                TextButton.icon(
                  onPressed: () {
                    colorDialog(context);
                  },
                  icon: Icon(Icons.color_lens_outlined),
                  label:
                      Text(DemoLocalizations.of(context).trans('choose_color')),
                ),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    child: Text(
                      DemoLocalizations.of(context).trans('cancel'),
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text(
                      DemoLocalizations.of(context).trans('ok'),
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Provider.of<TodoProvider>(context, listen: false)
                            .addTodo(
                          _titleController.text.trim(),
                          currentColor.toString(),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> colorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            DemoLocalizations.of(context).trans('choose_color'),
            style: TextStyle(fontSize: 20.sp),
          ),
          content: Container(
            //    height: 0.2.h,
            height: MediaQuery.of(context).size.height * 0.2,
            child: BlockPicker(
              availableColors: [
                Color(0xfff2dba0),
                Color(0xffff4545),
                Color(0xffffe345),
                Color(0xffffa321),
                Color(0xffff6421),
                Color(0xff874f00),
                Color(0xff00e636),
                Color(0xff857875),
              ],
              pickerColor: currentColor,
              onColorChanged: (Color color) {
                currentColor = color;
              },
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(currentColor.toString());
                },
                child: Text(
                  DemoLocalizations.of(context).trans('ok'),
                )),
          ],
        );
      },
    );
  }

  Future<void> addTask(BuildContext context, idTodo) {
    final _titleController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            DemoLocalizations.of(context).trans('add_new_task'),
            style: TextStyle(fontSize: 20.sp),
          ),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _titleController,
              validator: (value) {
                if (value.isEmpty) {
                  return DemoLocalizations.of(context)
                      .trans('please_enter_title');
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: DemoLocalizations.of(context).trans('title'),
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  child: Text(
                    DemoLocalizations.of(context).trans('cancel'),
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    DemoLocalizations.of(context).trans('ok'),
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Provider.of<TaskProvider>(context, listen: false).addTask(
                        idTodo,
                        _titleController.text.trim(),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Future<void> deleteTodo(BuildContext context, idTodo) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            DemoLocalizations.of(context).trans('delete_todo'),
            style: TextStyle(fontSize: 20.sp),
          ),
          content: Text(
            DemoLocalizations.of(context).trans('are_you_sure'),
            style: TextStyle(fontSize: 17.sp),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  child: Text(
                    DemoLocalizations.of(context).trans('cancel'),
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    DemoLocalizations.of(context).trans('yes'),
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    Provider.of<TodoProvider>(context, listen: false)
                        .removeItem(idTodo);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        DemoLocalizations.of(context).trans('delete_success'),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      duration: const Duration(seconds: 2),
                    ));
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  //Notes

  Future<void> addNoteDialog(BuildContext context) async {
    final _titleController = TextEditingController();
    final _textController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              DemoLocalizations.of(context).trans('add_new_note'),
              style: TextStyle(fontSize: 20.sp),
            ),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _titleController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return DemoLocalizations.of(context)
                            .trans('please_enter_title');
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText:
                          DemoLocalizations.of(context).trans('enter_title'),
                      hintText: DemoLocalizations.of(context).trans('title'),
                    ),
                  ),
                  TextFormField(
                    controller: _textController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return DemoLocalizations.of(context)
                            .trans('please_enter_text');
                      }
                      return null;
                    },
                    maxLines: 10,
                    // textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: DemoLocalizations.of(context).trans('text'),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    child: Text(
                      DemoLocalizations.of(context).trans('cancel'),
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text(
                      DemoLocalizations.of(context).trans('ok'),
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Provider.of<NoteProvider>(context, listen: false)
                            .addNote(_titleController.text.trim(),
                                _textController.text.trim(), getDate(context));
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  String getDate(BuildContext context) {
    var date = DateFormat.yMMMd().add_jm().format(DateTime.now()).toString();
    /*
    final lang = Provider.of<LangProvider>(context, listen: false);
    lang.language == 'en'
        ? date = DateFormat.yMMMd().add_jm().format(DateTime.now()).toString()
        : date = DateFormat.yMMMd('ar_SA')
            .add_jm()
            .format(DateTime.now())
            .toString();
*/
    return date;
  }
}
