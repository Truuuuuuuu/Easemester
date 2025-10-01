import 'package:flutter/material.dart';

class AchievementItem extends StatelessWidget {
  final String title;
  final String count;

  const AchievementItem({
    super.key,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontSize: 10),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
