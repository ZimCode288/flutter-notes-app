import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_notes_app/models/note.dart';
import 'package:flutter_notes_app/services/database_helper.dart';

void main() {
  // Initialize sqflite for ffi
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  group('Database CRUD Tests', () {
    late DatabaseHelper dbHelper;

    setUp(() {
      dbHelper = DatabaseHelper();
    });

    test('Insert and Query Note', () async {
      final note = Note(
        title: 'Test Note',
        content: 'Test Content',
        createdAt: DateTime.now(),
      );

      final id = await dbHelper.insert(note);
      expect(id, isNotNull);

      final notes = await dbHelper.queryAll();
      expect(notes.length, greaterThan(0));
      expect(notes.first.title, 'Test Note');
    });

    test('Update Note', () async {
      final notes = await dbHelper.queryAll();
      final note = notes.first;
      
      final updatedNote = note.copyWith(title: 'Updated Title');
      await dbHelper.update(updatedNote);

      final updatedNotes = await dbHelper.queryAll();
      expect(updatedNotes.first.title, 'Updated Title');
    });

    test('Delete Note', () async {
      final notes = await dbHelper.queryAll();
      final id = notes.first.id!;
      
      await dbHelper.delete(id);

      final remainingNotes = await dbHelper.queryAll();
      expect(remainingNotes.any((n) => n.id == id), isFalse);
    });
  });
}
