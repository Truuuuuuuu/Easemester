import '../models/note.dart';

class NotesController {
  final List<Note> notes = [];
  final Set<int> selectedNotes = {};
  bool selectionMode = false;
  String searchQuery = "";

  void addNote(String title, String content) {
    notes.add(Note(title: title, content: content));
  }

  void toggleSelectionMode() {
    selectionMode = !selectionMode;
    selectedNotes.clear();
  }

  void toggleSelection(int index) {
    if (selectedNotes.contains(index)) {
      selectedNotes.remove(index);
    } else {
      selectedNotes.add(index);
    }
  }

  void deleteSelected() {
    final indexes = selectedNotes.toList()
      ..sort((a, b) => b.compareTo(a));
    for (final i in indexes) {
      notes.removeAt(i);
    }
    selectedNotes.clear();
    selectionMode = false;
  }

  List<Note> get filteredNotes {
    if (searchQuery.isEmpty) return notes;
    return notes.where((note) {
      final title = note.title.toLowerCase();
      final content = note.content.toLowerCase();
      final query = searchQuery.toLowerCase();
      return title.contains(query) || content.contains(query);
    }).toList();
  }
}
