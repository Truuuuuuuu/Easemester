import 'package:flutter/material.dart';

class ChecklistItem extends StatelessWidget {
  final String title;
  final String? description;
  final bool done;
  final bool selectionMode;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;
  final VoidCallback? onDelete;

  const ChecklistItem({
    super.key,
    required this.title,
    this.description,
    required this.done,
    required this.selectionMode,
    required this.isSelected,
    required this.onChanged,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      color: isSelected
          ? Colors.blue.withOpacity(0.1)
          : null,
      child: ListTile(
        leading: selectionMode
            ? Checkbox(value: isSelected, onChanged: (_) {})
            : Checkbox(value: done, onChanged: onChanged),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: done
                ? TextDecoration.lineThrough
                : null,
          ),
        ),
        subtitle:
            description != null && description!.isNotEmpty
            ? Text(
                description!,
                style: TextStyle(
                  color: Colors.grey[700],
                  decoration: done
                      ? TextDecoration.lineThrough
                      : null,
                ),
              )
            : null,
      ),
    );
  }
}
