import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback? onDelete;
  final bool selectionMode;
  final bool isSelected;

  const NoteCard({
    super.key,
    required this.title,
    required this.content,
    this.onDelete,
    this.selectionMode = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: isSelected
          ? Colors.blue.withOpacity(
              0.2,
            ) // 🔹 highlight when selected
          : null,
      child: Stack(
        children: [
          // Main note layout
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

                // Content
                Expanded(
                  child: Text(
                    content,
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
