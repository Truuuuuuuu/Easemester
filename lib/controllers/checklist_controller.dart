import 'package:flutter/material.dart';
import '../models/task_model.dart';

class ChecklistController extends ChangeNotifier {
  final List<TaskModel> tasks = [];
  final Set<int> selectedTasks = {};
  bool selectionMode = false;

  void addTask(String title, String description) {
    tasks.add(
      TaskModel(title: title, description: description),
    );
    notifyListeners();
  }

  void toggleSelectionMode() {
    selectionMode = !selectionMode;
    selectedTasks.clear();
    notifyListeners();
  }

  void toggleSelection(int index) {
    if (selectedTasks.contains(index)) {
      selectedTasks.remove(index);
    } else {
      selectedTasks.add(index);
    }
    notifyListeners();
  }

  void clearSelection() {
    selectedTasks.clear();
    selectionMode = false;
    notifyListeners();
  }

  void deleteSelected() {
    final indexes = selectedTasks.toList()
      ..sort((a, b) => b.compareTo(a));
    for (final i in indexes) {
      tasks.removeAt(i);
    }
    selectedTasks.clear();
    selectionMode = false;
    notifyListeners();
  }
}
