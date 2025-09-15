import 'package:easemester_app/views/widgets/note_card.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => NotesPageState();
}

class NotesPageState extends State<NotesPage> {
  final List<Map<String, dynamic>> notes = [];

  void addNote() {
    setState(() {
      notes.add({
        "title": "Note ${notes.length + 1}",
        "content": "This is a sample note.",
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes")),
      body: notes.isEmpty
          ? const Center(
              child: Text(
                "No notes yet. Tap + to add one!",
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return NoteCard(
                  title: note["title"],
                  content: note["content"],
                  onDelete: () {
                    setState(() {
                      notes.removeAt(index);
                    });
                  },
                );
              },
            ),
    );
  }
}
