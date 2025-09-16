import 'package:flutter/material.dart';
import '../../controllers/notes_controller.dart';
import '../../models/note.dart';
import '../widgets/note_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => NotesPageState();
}

class NotesPageState extends State<NotesPage> {
  final NotesController controller = NotesController();
  final TextEditingController searchController =
      TextEditingController();

  /// Exposed so [app_actions.dart] can call it via GlobalKey
  void addNote() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("New Note"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                hintText: "Enter note title",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: "Description",
                hintText: "Enter note description",
              ),
              maxLines: 3,
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
                  controller.addNote(
                    titleController.text,
                    contentController.text,
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
              backgroundColor: Colors.red, // red background
              foregroundColor: Colors.white, // white text
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
    final filteredNotes = controller.filteredNotes;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.selectionMode
              ? "${controller.selectedNotes.length} selected"
              : "Notes",
        ),
        actions: [
          if (controller.selectionMode)
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons
                    .trashCan, 
                color: controller.selectedNotes.isNotEmpty
                    ? Colors.red
                    : null,
              ),
              onPressed: controller.selectedNotes.isEmpty
                  ? null
                  : _confirmDelete,
            ),
          IconButton(
            icon: FaIcon(
              controller.selectionMode
                  ? Icons.close
                  : FontAwesomeIcons.trashCan, 
              color: Colors.grey,
            ),
            onPressed: () =>
                setState(controller.toggleSelectionMode),
          ),
        ],
      ),
      body: Column(
        children: [
          if (!controller.selectionMode)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    controller.searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search notes...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
          Expanded(
            child: filteredNotes.isEmpty
                ? Center(
                    child: Text(
                      controller.searchQuery.isNotEmpty
                          ? "Couldn’t find any notes" // search but no result
                          : "No notes yet. Tap + to add one!", // when completely empty
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredNotes.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1,
                        ),
                    itemBuilder: (context, index) {
                      final Note note =
                          filteredNotes[index];
                      final realIndex = controller.notes
                          .indexOf(note);
                      final isSelected = controller
                          .selectedNotes
                          .contains(realIndex);

                      return GestureDetector(
                        onLongPress: () {
                          if (!controller.selectionMode) {
                            setState(() {
                              controller.selectionMode =
                                  true;
                              controller.selectedNotes.add(
                                realIndex,
                              );
                            });
                          }
                        },
                        onTap: () {
                          if (controller.selectionMode) {
                            setState(
                              () => controller
                                  .toggleSelection(
                                    realIndex,
                                  ),
                            );
                          }
                        },
                        child: NoteCard(
                          title: note.title,
                          content: note.content,
                          isSelected: isSelected,
                          selectionMode:
                              controller.selectionMode,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
