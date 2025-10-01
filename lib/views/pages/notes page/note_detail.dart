import 'package:easemester_app/controllers/notes_controller.dart';
import 'package:easemester_app/models/note_model.dart';
import 'package:flutter/material.dart';

class NoteDetailPage extends StatefulWidget {
  final NoteModel note;
  final NotesController controller;

  const NoteDetailPage({
    super.key,
    required this.note,
    required this.controller,
  });

  @override
  State<NoteDetailPage> createState() =>
      _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.note.title,
    );
    _contentController = TextEditingController(
      text: widget.note.content,
    );
  }

  void _saveNote() {
    final updatedNote = widget.note.copyWith(
      title: _titleController.text,
      content: _contentController.text,
      updatedAt: DateTime.now(),
    );

    widget.controller.updateNote(updatedNote);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _saveNote(); // Save on back
        return true; // Allow back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: Hero(
            tag: widget.note.title,
            child: Material(
              type: MaterialType.transparency,
              child: TextField(
                controller: _titleController,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Hero(
              tag: '${widget.note.title}-content',
              child: Material(
                type: MaterialType.transparency,
                child: TextField(
                  controller: _contentController,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
