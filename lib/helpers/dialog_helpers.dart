import 'package:flutter/material.dart';
import '../controllers/notes_controller.dart';
import '../controllers/checklist_controller.dart';

/// Confirm deletion for Notes
Future<void> confirmDeleteNotes(
  BuildContext context,
  NotesController controller,
) async {
  if (controller.selectedNotes.isEmpty) return;

  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Delete Notes"),
      content: Text(
        "Are you sure you want to delete ${controller.selectedNotes.length} selected note(s)?",
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          onPressed: () => Navigator.pop(context, true),
          child: const Text("Delete"),
        ),
      ],
    ),
  );

  if (confirm == true) {
    controller.deleteSelected();
  }
}

/// Confirm deletion for Checklist tasks
Future<void> confirmDeleteTasks(
  BuildContext context,
  ChecklistController controller,
) async {
  if (controller.selectedTasks.isEmpty) return;

  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Delete Tasks"),
      content: Text(
        "Are you sure you want to delete ${controller.selectedTasks.length} selected task(s)?",
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          onPressed: () => Navigator.pop(context, true),
          child: const Text("Delete"),
        ),
      ],
    ),
  );

  if (confirm == true) {
    controller.deleteSelected();
  }
}

/// Generic input dialog for adding Notes or Tasks
Future<Map<String, String>?> showInputDialog({
  required BuildContext context,
  required String title,
  required List<String> fields,
}) async {
  final Map<String, TextEditingController> controllers = {
    for (var field in fields)
      field: TextEditingController(),
  };

  final result = await showDialog<Map<String, String>>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: fields
            .map(
              (field) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                ),
                child: TextField(
                  controller: controllers[field],
                  decoration: InputDecoration(
                    labelText: field,
                  ),
                  maxLines:
                      field.toLowerCase() == 'content' ||
                          field.toLowerCase() ==
                              'description'
                      ? 3
                      : 1,
                ),
              ),
            )
            .toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final Map<String, String> values = {
              for (var field in fields)
                field: controllers[field]!.text,
            };
            Navigator.pop(context, values);
          },
          child: const Text("Add"),
        ),
      ],
    ),
  );

  return result;
}

/// Confirm changes dialog (e.g., before saving profile edits)
Future<bool?> confirmChanges(BuildContext context) async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Confirm Changes"),
      content: const Text(
        "Are you sure you want to save these changes?",
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
          ),
          onPressed: () => Navigator.pop(context, true),
          child: const Text("Save"),
        ),
      ],
    ),
  );

  return confirm;
}

/// Confirm sign out dialog
Future<bool?> confirmSignOut(BuildContext context) async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Sign Out"),
      content: const Text(
        "Are you sure you want to sign out?",
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
          ),
          onPressed: () => Navigator.pop(context, true),
          child: const Text("Sign Out"),
        ),
      ],
    ),
  );

  return confirm;
}
