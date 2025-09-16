import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../controllers/checklist_controller.dart';
import '../../models/task.dart';
import '../widgets/checklist_card.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  State<ChecklistPage> createState() =>
      ChecklistPageState();
}

class ChecklistPageState extends State<ChecklistPage> {
  final ChecklistController controller =
      ChecklistController();

  /// Exposed so [app_actions.dart] can call it via GlobalKey
  void addChecklistItem() {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("New Task"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                labelText: "Description",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                setState(() {
                  controller.addTask(
                    titleController.text,
                    descController.text,
                  );
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete() async {
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
      setState(controller.deleteSelected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.selectionMode
              ? "${controller.selectedTasks.length} selected"
              : "Checklist",
        ),
        actions: [
          if (controller.selectionMode)
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.trashCan),
              onPressed: controller.selectedTasks.isEmpty
                  ? null
                  : _confirmDelete,
                  color: Colors.red,
            ),
          IconButton(
            icon: FaIcon(
              controller.selectionMode
                  ? Icons.close
                  : FontAwesomeIcons.trashCan,
            ),
            onPressed: () =>
                setState(controller.toggleSelectionMode),
          ),
        ],
      ),
      body: controller.tasks.isEmpty
          ? const Center(
              child: Text(
                "No tasks yet. Tap + to add one!",
              ),
            )
          : ListView.builder(
              itemCount: controller.tasks.length,
              itemBuilder: (context, index) {
                final Task task = controller.tasks[index];
                final isSelected = controller.selectedTasks
                    .contains(index);

                return GestureDetector(
                  onLongPress: () {
                    if (!controller.selectionMode) {
                      setState(() {
                        controller.selectionMode = true;
                        controller.selectedTasks.add(index);
                      });
                    }
                  },
                  onTap: () {
                    if (controller.selectionMode) {
                      setState(
                        () => controller.toggleSelection(
                          index,
                        ),
                      );
                    }
                  },
                  child: ChecklistItem(
                    title: task.title,
                    description: task.description,
                    done: task.done,
                    isSelected: isSelected,
                    selectionMode: controller.selectionMode,
                    onChanged: (value) {
                      setState(() {
                        task.done = value ?? false;
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}
