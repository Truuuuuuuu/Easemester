import '../models/task.dart';

class ChecklistController {
  final List<Task> tasks = [];
  final Set<int> selectedTasks = {};
  bool selectionMode = false;

  void addTask(String title, String description) {
    tasks.add(Task(title: title, description: description));
  }

  void toggleSelectionMode() {
    selectionMode = !selectionMode;
    selectedTasks.clear();
  }

  void toggleSelection(int index) {
    if (selectedTasks.contains(index)) {
      selectedTasks.remove(index);
    } else {
      selectedTasks.add(index);
    }
  }

  void deleteSelected() {
    final indexes = selectedTasks.toList()
      ..sort((a, b) => b.compareTo(a));
    for (final i in indexes) {
      tasks.removeAt(i);
    }
    selectedTasks.clear();
    selectionMode = false;
  }
}
