import 'package:sqflite/sqflite.dart';

import 'create_tables.dart';

class DBTodoHelper {
  static Future<void> insertTodo(Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      'todo',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> insertTask(Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      'task',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getTodoData() async {
    final db = await DBHelper.database();
    return db.query('todo', orderBy: 'id_todo');
  }

  static Future<List<Map<String, dynamic>>> getTaskData(idTodo) async {
    final db = await DBHelper.database();
    return db.query('task',
        orderBy: 'id_task', where: 'id_todo = ?', whereArgs: [idTodo]);
  }

  static Future<void> updateTodoTitle(
      String id, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.update('todo', data, where: 'id_todo = ?', whereArgs: [id]);
  }

  static Future<void> updateCheckTask(
      String id, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.update('task', data, where: 'id_task = ?', whereArgs: [id]);
  }

  static Future<void> deleteTodo(String id) async {
    final db = await DBHelper.database();
    db.delete('todo', where: 'id_todo = ?', whereArgs: [id]);
  }

  static Future<void> deleteTask(String id) async {
    final db = await DBHelper.database();
    db.delete('task', where: 'id_task = ?', whereArgs: [id]);
  }
}
