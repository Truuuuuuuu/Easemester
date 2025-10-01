import 'package:flutter/material.dart';
import 'package:easemester_app/models/note_model.dart';

class NoteCard extends StatelessWidget {
  final NoteModel note;
  final bool selectionMode;
  final bool isSelected;

  const NoteCard({
    super.key,
    required this.note,
    this.selectionMode = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: note.title, 
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: isSelected
            ? Colors.blue.withOpacity(0.2)
            : null,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Expanded(
                child: Text(
                  note.content,
                  style: const TextStyle(fontSize: 14),
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
