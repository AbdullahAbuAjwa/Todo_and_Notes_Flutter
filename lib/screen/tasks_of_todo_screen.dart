import 'package:flutter/material.dart';
import 'package:tood_and_note/ModelAndProvider/Task.dart';
import 'package:tood_and_note/ModelAndProvider/dialogs.dart';
import 'package:tood_and_note/widget/task_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';

class TasksOfTodoScreen extends StatefulWidget {
  @override
  _TasksOfTodoScreenState createState() => _TasksOfTodoScreenState();
}

class _TasksOfTodoScreenState extends State<TasksOfTodoScreen> {
  @override
  Widget build(BuildContext context) {
    final idTodo = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).trans('tasks')),
        actions: [
          IconButton(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).padding.left),
            icon: Icon(
              Icons.add_circle_outline,
              size: 28.sp,
            ),
            onPressed: () {
              Provider.of<DialogsProvider>(context, listen: false)
                  .addTask(context, idTodo);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<TaskProvider>(context, listen: false).fetchTask(idTodo),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Hero(
                    tag: idTodo,
                    child: Consumer<TaskProvider>(
                      child: Center(
                        child: Text(
                          DemoLocalizations.of(context).trans('no_items'),
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      builder: (context, task, Widget child) =>
                          task.items.length <= 0
                              ? child
                              : ListView.builder(
                                  itemCount: task.items.length,
                                  itemBuilder: (ctx, i) => Container(
                                    child: TaskItem(
                                      idTask: task.items[i].idTask,
                                      idTodo: task.items[i].idTodo,
                                      isChecked: task.items[i].isChecked,
                                      text: task.items[i].text,
                                    ),
                                  ),
                                ),
                    ),
                  ),
      ),
    );
  }
}
