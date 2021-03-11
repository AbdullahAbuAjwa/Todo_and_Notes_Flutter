import 'package:flutter/material.dart';
import 'package:tood_and_note/DB/db-todo.dart';

import 'Task.dart';

class Todo {
  var idTodo;
  var title;
  var color;
  List<Task> tasks;

  Todo({this.idTodo, this.title, this.color, this.tasks});
}

class TodoProvider with ChangeNotifier {
  List<Todo> _items = [];

  List<Todo> get items {
    return [..._items];
  }

  void addTodo(title, color) {
    final Todo todo = new Todo(
      idTodo: DateTime.now().toString(),
      title: title,
      color: color,
    );
    _items.add(todo);
    notifyListeners();

    DBTodoHelper.insertTodo({
      'id_todo': todo.idTodo,
      'title': todo.title,
      'color': todo.color,
    });
  }

  Future<void> fetchTodo() async {
    final dataList = await DBTodoHelper.getTodoData();
    _items = dataList
        .map((item) => new Todo(
              idTodo: item['id_todo'],
              title: item['title'],
              color: item['color'],
            ))
        .toList();
    notifyListeners();
  }

  void updateInfoTodo(String id, String title) {
    Todo todo = Todo(title: title);
    DBTodoHelper.updateTodoTitle(id, {
      'title': todo.title,
    });
  }

  void removeItem(id) {
    _items.removeWhere((item) => item.idTodo == id);
    DBTodoHelper.deleteTodo(id);
    notifyListeners();
  }
}
