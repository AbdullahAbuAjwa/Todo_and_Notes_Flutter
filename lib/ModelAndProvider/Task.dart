import 'package:flutter/cupertino.dart';
import 'package:tood_and_note/DB/db-todo.dart';

class Task {
  var idTodo;
  var idTask;
  var text;
  var isChecked;

  Task({this.idTodo, this.idTask, this.text, this.isChecked});
}

class TaskProvider with ChangeNotifier {
  List<Task> _items = [];

  List<Task> get items {
    return [..._items];
  }

  void addTask(idTodo, text) {
    final Task task = new Task(
      idTask: DateTime.now().toString(),
      idTodo: idTodo,
      text: text,
      isChecked: 0,
    );
    _items.add(task);
    notifyListeners();

    DBTodoHelper.insertTask({
      'id_todo': task.idTodo,
      'id_task': task.idTask,
      'text': task.text,
      'isChecked': 0,
    });
  }

  Future<void> fetchTask(idTodo) async {
    final dataList = await DBTodoHelper.getTaskData(idTodo);
    _items = dataList
        .map((item) => new Task(
              idTodo: item['id_todo'],
              idTask: item['id_task'],
              text: item['text'],
              isChecked: item['isChecked'],
            ))
        .toList();
    notifyListeners();
  }

  void updateCheckTask(idTask, isChecked) {
    Task task = Task(isChecked: isChecked);
    DBTodoHelper.updateCheckTask(idTask, {
      'isChecked': task.isChecked == 0 ? 1 : 0,
    });
  }

  void removeTask(id) {
    _items.removeWhere((item) => item.idTask == id);
    DBTodoHelper.deleteTask(id);
    notifyListeners();
  }
}
