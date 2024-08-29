import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'note.dart';

class NotesDatabase extends ChangeNotifier{
  static late Isar isar;

// I N I T A L I Z E

  static Future<void> initalize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  final List<Note> currentNotes = [];

//C R E A T E
  Future<void> addNote(String text) async {
    var newNote = Note()..text = text;
    await isar.writeTxn(() => isar.notes.put(newNote));
    readNotes();
    notifyListeners();
  }

//R E A D
  Future<void> readNotes() async {
    List<Note> readNotes = await isar.notes.where().findAll();

    currentNotes.clear();
    currentNotes.addAll(readNotes);
    notifyListeners();
  }

// U P D A T E
  Future<void> updateNote(int id, String newText) async {
    var existingNote = await isar.notes.get(id);

    if (existingNote != null) {
      existingNote.text = newText;

      await isar.writeTxn(() => isar.notes.put(existingNote));
      await readNotes();
    }
  }

//D E L E T E
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await readNotes();
  }
}
