import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/database_helper.dart';

class NotesProvider with ChangeNotifier {
  List<Note> _notes = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Note> get notes => _notes;

  Future<void> loadNotes() async {
    _notes = await _dbHelper.queryAll();
    notifyListeners();
  }

  Future<void> addNote(String title, String content) async {
    Note newNote = Note(
      title: title,
      content: content,
      createdAt: DateTime.now(),
    );
    await _dbHelper.insert(newNote);
    await loadNotes();
  }

  Future<void> updateNote(Note note) async {
    await _dbHelper.update(note);
    await loadNotes();
  }

  Future<void> deleteNote(int id) async {
    await _dbHelper.delete(id);
    await loadNotes();
  }
}
