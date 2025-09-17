import 'package:easemester_app/data/constant.dart';
import 'package:easemester_app/models/note_model.dart';
import 'package:flutter/material.dart';

class NoteDetailPage extends StatelessWidget {
  final NoteModel note;

  const NoteDetailPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: note
              .title, // 🔹 Must match the Hero tag in NoteCard
          child: Material(
            type: MaterialType
                .transparency, // avoids text flicker
            child: Text(
              note.title,
              style: AppFonts.heading1,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Hero(
          tag:
              '${note.title}-content', // 🔹 unique tag for content
          child: Material(
            type: MaterialType.transparency,
            child: Text(
              note.content,
              style: const TextStyle( 
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
