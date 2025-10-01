import 'package:easemester_app/repositories/notes_repository.dart';
import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NotesController extends ChangeNotifier {
  final NotesRepository repository;
  final String uid;

  // State
  List<NoteModel> _notes = [];
  List<NoteModel> get notes => _notes;

  final Set<String> selectedNotes =
      {}; // store note IDs instead of indexes
  bool selectionMode = false;
  String searchQuery = "";

  NotesController({
    required this.repository,
    required this.uid,
  }) {
    _listenToNotes();
  }

  // Listen to Firestore notes in real-time
  void _listenToNotes() {
    repository.getNotes(uid).listen((notesData) {
      _notes = notesData;
      notifyListeners();
    });
  }

  // <<<ADD>>>
  Future<void> addNote(String title, String content) async {
    final note = NoteModel(
      id: '',
      title: title,
      content: content,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await repository.addNote(uid, note);
  }

  // <<<UPDATE>>>
  Future<void> updateNote(NoteModel note) async {
    final updated = note.copyWith(
      updatedAt: DateTime.now(),
    );
    await repository.updateNote(uid, updated);
  }

  // <<<DELETE>>>
  Future<void> deleteNote(String noteId) async {
    await repository.deleteNote(uid, noteId);
  }

  // <<<SELECTION>>>
  void startSelection(String noteId) {
    selectionMode = true;
    selectedNotes.add(noteId);
    notifyListeners();
  }

  void clearSelection() {
    selectedNotes.clear();
    selectionMode = false;
    notifyListeners();
  }

  void toggleSelectionMode() {
    selectionMode = !selectionMode;
    selectedNotes.clear();
    notifyListeners();
  }

  void toggleSelection(String noteId) {
    if (selectedNotes.contains(noteId)) {
      selectedNotes.remove(noteId);
    } else {
      selectedNotes.add(noteId);
    }
    notifyListeners();
  }

  Future<void> deleteSelected() async {
    for (final id in selectedNotes) {
      await repository.deleteNote(uid, id);
    }
    selectedNotes.clear();
    selectionMode = false;
    notifyListeners();
  }

  // <<<SEARCH>>>
  void setSearchQuery(String query) {
    searchQuery = query;
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
