import 'package:flutter/material.dart';
import 'package:tood_and_note/DB/db-note.dart';

class Note with ChangeNotifier {
  var id;
  var title;
  var text;
  var dateTime;
  var isFav;

  Note({this.id, this.title, this.text, this.dateTime, this.isFav});
}

class NoteProvider with ChangeNotifier {
  List<Note> _items = [];

  List<Note> get items {
    return [..._items];
  }

  void addNote(String title, String text, dateTime) {
    final Note note = new Note(
      id: DateTime.now().toString(),
      title: title,
      text: text,
      dateTime: dateTime,
      //DateFormat.yMMMd().add_jm().format(DateTime.now()).toString(),
      isFav: 0,
    );
    _items.add(note);
    notifyListeners();

    DBNoteHelper.insert({
      'id': note.id,
      'title': note.title,
      'text': note.text,
      'time': note.dateTime,
      'isFav': 0
    });
  }

  Future<void> fetchNotes() async {
    final dataList = await DBNoteHelper.getData();
    _items = dataList
        .map((item) => new Note(
              id: item['id'],
              title: item['title'],
              text: item['text'],
              dateTime: item['time'],
              isFav: item['isFav'],
            ))
        .toList();
    notifyListeners();
  }

  Future<void> fetchFavNotes() async {
    final dataList = await DBNoteHelper.getFavoritesData();
    _items = dataList
        .map((item) => new Note(
              id: item['id'],
              title: item['title'],
              text: item['text'],
              dateTime: item['time'],
              isFav: item['isFav'],
            ))
        .toList();
    notifyListeners();
  }

  void removeItem(String id) {
    DBNoteHelper.delete(id);
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void updateFavNote(String id, int isFav) {
    Note note = Note(isFav: isFav);
    DBNoteHelper.update(id, {
      'isFav': note.isFav == 0 ? 1 : 0,
    });
  }

  void updateInfoNote(String id, String title, String text) {
    Note note = Note(title: title, text: text);
    DBNoteHelper.update(id, {
      'title': note.title,
      'text': note.text,
    });
  }

  Note findByID(String id) {
    return _items.firstWhere((p) => p.id == id);
  }
}
