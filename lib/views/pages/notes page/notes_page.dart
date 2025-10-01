import 'package:flutter/material.dart';
import '../../../controllers/notes_controller.dart';
import '../../widgets/cards/note_card.dart';
import 'note_detail.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../helpers/dialog_helpers.dart';

class NotesPage extends StatefulWidget {
  final NotesController controller;

  const NotesPage({super.key, required this.controller});

  @override
  NotesPageState createState() => NotesPageState();
}

class NotesPageState extends State<NotesPage> {
  NotesController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final filteredNotes = controller.filteredNotes;
        
        return Scaffold(
          appBar: AppBar(
            title: Text(
              controller.selectionMode
                  ? "${controller.selectedNotes.length} selected"
                  : "Notes",
            ),
            actions: [
              // Show trashcan only in selection mode
              if (controller.selectionMode)
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.trashCan,
                    color:
                        controller.selectedNotes.isNotEmpty
                        ? Colors.red
                        : null,
                  ),
                  onPressed:
                      controller.selectedNotes.isEmpty
                      ? null
                      : () => confirmDeleteNotes(
                          context,
                          controller,
                        ),
                ),
              // Close selection mode button
              if (controller.selectionMode)
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      controller.clearSelection();
                    });
                  },
                ),
            ],
          ),
          body: Column(
            children: [
              if (!controller.selectionMode)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    onChanged: (value) {
                      controller.setSearchQuery(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Search notes...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(
                        0.05,
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: filteredNotes.isEmpty
                    ? Center(
                        child: Text(
                          controller.searchQuery.isNotEmpty
                              ? "Couldn’t find any notes"
                              : "No notes yet. Tap + to add one!",
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
                          final note = filteredNotes[index];
                          final isSelected = controller
                              .selectedNotes
                              .contains(note.id);
                          ;

                          return GestureDetector(
                            onLongPress: () {
                              if (!controller
                                  .selectionMode) {
                                controller.startSelection(
                                  note.id,
                                );
                              }
                            },
                            onTap: () {
                              if (controller
                                  .selectionMode) {
                                setState(
                                  () => controller
                                      .toggleSelection(
                                        note.id,
                                      ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        NoteDetailPage(
                                          note: note,
                                        ),
                                  ),
                                );
                              }
                            },
                            child: NoteCard(
                              note: note,
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
      },
    );
  }
}
