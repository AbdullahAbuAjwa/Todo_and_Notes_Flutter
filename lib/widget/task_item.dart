import 'package:flutter/material.dart';
import 'package:tood_and_note/ModelAndProvider/Task.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskItem extends StatefulWidget {
  final idTodo;
  final idTask;
  final text;
  final isChecked;

  const TaskItem({this.idTodo, this.idTask, this.text, this.isChecked});

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool checked;

  @override
  void initState() {
    checked = widget.isChecked == 0 ? false : true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      secondary: InkWell(
        onTap: () {
          Provider.of<TaskProvider>(context, listen: false)
              .removeTask(widget.idTask);
        },
        child: const Icon(Icons.delete_outline),
      ),
      title: Text(
        widget.text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 17.sp,
          decoration: widget.isChecked == 1
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      activeColor: Colors.black,
      value: checked,
      onChanged: (bool value) {
        setState(() {
          Provider.of<TaskProvider>(context, listen: false)
              .updateCheckTask(widget.idTask, widget.isChecked);
          checked = value;
        });
      },
    );
  }
}
