import 'package:easemester_app/models/task_model.dart';
import 'package:easemester_app/repositories/checklist_repository.dart';
import 'package:flutter/material.dart';

class ChecklistController extends ChangeNotifier {
  final ChecklistRepository repository;
  final String uid;

  List<ChecklistItem> _items = [];
  List<ChecklistItem> get items => _items;

  final Set<String> selectedTasks = {};
  bool selectionMode = false;

  ChecklistController({
    required this.repository,
    required this.uid,
  }) {
    _listenToItems();
  }

  void _listenToItems() {
    repository.getItems(uid).listen((data) {
      _items = data;
      notifyListeners();
    });
  }

  Future<void> addItem(String title) async {
    final item = ChecklistItem(
      id: '',
      title: title,
      completed: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await repository.addItem(uid, item);
  }

  Future<void> toggleCompleted(ChecklistItem item) async {
    final updated = item.copyWith(
      completed: !item.completed,
      updatedAt: DateTime.now(),
    );
    await repository.updateItem(uid, updated);
  }

  Future<void> deleteItem(String id) async {
    await repository.deleteItem(uid, id);
  }

  
  // Selection & multi-delete
  void startSelection(String itemId) {
    selectionMode = true;
    selectedTasks.add(itemId);
    notifyListeners();
  }

  void toggleSelection(String itemId) {
    if (selectedTasks.contains(itemId)) {
      selectedTasks.remove(itemId);
    } else {
      selectedTasks.add(itemId);
    }
    notifyListeners();
  }

  void clearSelection() {
    selectedTasks.clear();
    selectionMode = false;
    notifyListeners();
  }

  Future<void> deleteSelected() async {
    for (final id in selectedTasks) {
      await deleteItem(id);
    }
    clearSelection();
  }
}
