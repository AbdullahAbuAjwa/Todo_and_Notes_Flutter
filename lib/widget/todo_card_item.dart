import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tood_and_note/ModelAndProvider/Todo.dart';
import 'package:tood_and_note/ModelAndProvider/dialogs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../main.dart';

class TodoCardItem extends StatefulWidget {
  var idTodo;
  var title;
  var color;

  TodoCardItem({this.idTodo, this.title, this.color});

  @override
  _TodoCardItemState createState() => _TodoCardItemState();
}

class _TodoCardItemState extends State<TodoCardItem> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.idTodo,
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 135),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17.sp),
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                'move_to_todo_details',
                arguments: widget.idTodo,
              );
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.artifika(
                      textStyle: TextStyle(
                          color: Color(0xFF2e282a),
                          fontSize: 23.sp,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Provider.of<DialogsProvider>(context, listen: false)
                                .deleteTodo(context, widget.idTodo);
                          },
                          child: const Icon(
                            Icons.delete_forever,
                            color: Colors.black,
                          ),
                        ),
                        InkWell(
                          onTap: () => editTodoDialog(context),
                          child: const Icon(
                            Icons.edit_sharp,
                            color: Colors.black,
                          ),
                        ),
                        InkWell(
                          onTap: () => Provider.of<DialogsProvider>(context,
                                  listen: false)
                              .addTask(context, widget.idTodo),
                          child: const Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          color: convertStringToColor(widget.color.toString()),
        ),
      ),
    );
  }

  Color convertStringToColor(colorString) {
    String valueString = colorString.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    return Color(value);
  }

  Future<String> editTodoDialog(BuildContext context) async {
    String title = widget.title;
    final _formKey = GlobalKey<FormState>();

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            DemoLocalizations.of(context).trans('delete_todo'),
            style: TextStyle(fontSize: 20.sp),
          ),
          content: Form(
            key: _formKey,
            child: TextFormField(
              initialValue: title,
              validator: (value) {
                if (value.isEmpty) {
                  return DemoLocalizations.of(context)
                      .trans('please_enter_title');
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: DemoLocalizations.of(context).trans('enter_title'),
              ),
              onChanged: (data) {
                title = data;
              },
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
                    DemoLocalizations.of(context).trans('save'),
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    setState(() {
                      if (_formKey.currentState.validate()) {
                        Provider.of<TodoProvider>(context, listen: false)
                            .updateInfoTodo(widget.idTodo, title.trim());
                        widget.title = title;
                        Navigator.of(context).pop();
                      }
                    });
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
