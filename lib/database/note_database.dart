import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_todo_bloc/model/note_model.dart';

class NoteDatabase {
  static const String boxName = "Note";

  Future<Box> openBox() async {
    var box = await Hive.openBox<Note>(boxName);
    return box;
  }

  Future<List<Note>> getAllNotes() async {
    final box = await openBox();
    List<Note> notes = List.from(box.values);
    return notes;
  }

  Future<void> addNote(Note note) async {
    final box = await openBox();
    await box.add(note);
  }

  Future<void> deleteNote(int index) async {
    final box = await openBox();
    box.deleteAt(index);
  }

  Future<void> deleteAll() async {
    final box = await openBox();
    box.clear();
  }

  Future<void> updateNote(Note note, int index) async {
    final box = await openBox();
    box.putAt(index, note);
  }
}
