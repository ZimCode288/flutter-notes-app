import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_notes_app/models/note.dart';

void main() {
  group('Note Model Tests', () {
    test('Note toMap() should return correct map', () {
      final now = DateTime.now();
      final note = Note(
        id: 1,
        title: 'Test Title',
        content: 'Test Content',
        createdAt: now,
      );

      final map = note.toMap();

      expect(map['id'], 1);
      expect(map['title'], 'Test Title');
      expect(map['content'], 'Test Content');
      expect(map['created_at'], now.toIso8601String());
    });

    test('Note fromMap() should return correct Note object', () {
      final now = DateTime.now();
      final map = {
        'id': 1,
        'title': 'Test Title',
        'content': 'Test Content',
        'created_at': now.toIso8601String(),
      };

      final note = Note.fromMap(map);

      expect(note.id, 1);
      expect(note.title, 'Test Title');
      expect(note.content, 'Test Content');
      expect(note.createdAt, now);
    });

    test('Note copyWith() should return updated Note object', () {
      final now = DateTime.now();
      final note = Note(
        id: 1,
        title: 'Original Title',
        content: 'Original Content',
        createdAt: now,
      );

      final updatedNote = note.copyWith(title: 'New Title');

      expect(updatedNote.id, 1);
      expect(updatedNote.title, 'New Title');
      expect(updatedNote.content, 'Original Content');
      expect(updatedNote.createdAt, now);
    });
  });
}
