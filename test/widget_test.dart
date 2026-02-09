import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_notes_app/main.dart';
import 'package:flutter_notes_app/providers/notes_provider.dart';
import 'package:flutter_notes_app/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen shows empty state when no notes', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => NotesProvider(),
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    expect(find.text('No notes yet. Tap + to add one.'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
