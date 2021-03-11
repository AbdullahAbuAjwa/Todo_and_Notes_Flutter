import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, 'note_app.db'),
        onCreate: (db, version) async {
      db.execute(
          'CREATE TABLE notes(id TEXT PRIMARY KEY, title TEXT, text TEXT, time TEXT , isFav INTEGER)');
      await db.execute(
          'CREATE TABLE todo(id_todo TEXT PRIMARY KEY , title TEXT, color TEXT)');
      await db.execute(
          'CREATE TABLE task(id_task TEXT PRIMARY KEY, id_todo TEXT, text TEXT, isChecked INTEGER, FOREIGN KEY(id_todo) REFERENCES todo(id_todo))');
    }, version: 1);
  }
}
