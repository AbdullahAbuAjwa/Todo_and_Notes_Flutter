import 'package:sqflite/sqflite.dart';

import 'create_tables.dart';

class DBNoteHelper {
  static Future<void> insert(Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      'notes',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await DBHelper.database();
    return db.query('notes', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getFavoritesData() async {
    final db = await DBHelper.database();
    return db.query('notes', orderBy: 'id', where: 'isFav = 1');
  }

  static Future<void> delete(String id) async {
    final db = await DBHelper.database();
    db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> update(String id, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.update('notes', data, where: 'id = ?', whereArgs: [id]);
  }
}
