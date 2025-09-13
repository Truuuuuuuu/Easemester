import 'package:flutter/material.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Checklist page'),
    );
  }
}
