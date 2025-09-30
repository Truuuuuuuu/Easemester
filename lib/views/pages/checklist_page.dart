import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../controllers/checklist_controller.dart';
import '../widgets/checklist_card.dart';
import '../../helpers/dialog_helpers.dart'; // <- Import helpers

class ChecklistPage extends StatefulWidget {
  final ChecklistController controller;

  const ChecklistPage({
    super.key,
    required this.controller,
  });

  @override
  ChecklistPageState createState() => ChecklistPageState();
}

class ChecklistPageState extends State<ChecklistPage> {
  ChecklistController get controller => widget.controller;

  void addChecklistItemDialog() async {
    final result = await showInputDialog(
      context: context,
      title: "New Task",
      fields: ["Title", "Description"],
    );

    if (result != null && result["Title"]!.isNotEmpty) {
      setState(() {
        controller.addTask(
          result["Title"]!,
          result["Description"] ?? "",
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              controller.selectionMode
                  ? "${controller.selectedTasks.length} selected"
                  : "Checklist",
            ),
            actions: [
              if (controller.selectionMode) ...[
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.trashCan,
                    color:
                        controller.selectedTasks.isNotEmpty
                        ? Colors.red
                        : null,
                  ),
                  onPressed:
                      controller.selectedTasks.isEmpty
                      ? null
                      : () => confirmDeleteTasks(
                          context,
                          controller,
                        ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      controller.clearSelection();
                    });
                  },
                ),
              ],
            ],
          ),
          body: controller.tasks.isEmpty
              ? Center(
                  child: Text(
                    "No task yet. Tap + to add one!",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                          fontSize: 14,
                          color: Theme.of(
                            context,
                          ).colorScheme.onBackground,
                        ),
                  ),
                )
              : ListView.builder(
                  itemCount: controller.tasks.length,
                  itemBuilder: (context, index) {
                    final task = controller.tasks[index];
                    final isSelected = controller
                        .selectedTasks
                        .contains(index);

                    return GestureDetector(
                      onLongPress: () {
                        if (!controller.selectionMode) {
                          setState(() {
                            controller.selectionMode = true;
                            controller.selectedTasks.add(
                              index,
                            );
                          });
                        }
                      },
                      onTap: () {
                        if (controller.selectionMode) {
                          setState(
                            () => controller
                                .toggleSelection(index),
                          );
                        }
                      },
                      child: ChecklistItem(
                        title: task.title,
                        description: task.description,
                        done: task.done,
                        isSelected: isSelected,
                        selectionMode:
                            controller.selectionMode,
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
      },
    );
  }
}
