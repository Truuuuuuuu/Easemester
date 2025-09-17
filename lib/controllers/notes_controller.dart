import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NotesController extends ChangeNotifier {
  final List<NoteModel> notes = [];
  final Set<int> selectedNotes = {};
  bool selectionMode = false;
  String searchQuery = "";

  void addNote(String title, String content) {
    notes.add(
      NoteModel(
        id: DateTime.now().millisecondsSinceEpoch
            .toString(),
        title: title,
        content: content,
      ),
    );
    notifyListeners();
  }

  void toggleSelectionMode() {
    selectionMode = !selectionMode;
    selectedNotes.clear();
    notifyListeners();
  }

  void toggleSelection(int index) {
    if (selectedNotes.contains(index)) {
      selectedNotes.remove(index);
    } else {
      selectedNotes.add(index);
    }
    notifyListeners();
  }

  void deleteSelected() {
    final indexes = selectedNotes.toList()
      ..sort((a, b) => b.compareTo(a));
    for (final i in indexes) {
      notes.removeAt(i);
    }
    selectedNotes.clear();
    selectionMode = false;
    notifyListeners();
  }

  List<NoteModel> get filteredNotes {
    if (searchQuery.isEmpty) return notes;
    return notes.where((note) {
      final title = note.title.toLowerCase();
      final content = note.content.toLowerCase();
      final query = searchQuery.toLowerCase();
      return title.contains(query) ||
          content.contains(query);
    }).toList();
  }
}
