import 'package:flutter/material.dart';

class ChecklistItem extends StatelessWidget {
  final String title;
  final bool done;
  final ValueChanged<bool?> onChanged;

  const ChecklistItem({
    super.key,
    required this.title,
    required this.done,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: CheckboxListTile(
        title: Text(
          title,
          style: TextStyle(
            decoration: done
                ? TextDecoration.lineThrough
                : null,
          ),
        ),
        value: done,
        onChanged: onChanged,
      ),
    );
  }
}
