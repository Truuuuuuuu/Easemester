import 'package:easemester_app/views/widgets/checklist_card.dart';
import 'package:flutter/material.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  State<ChecklistPage> createState() =>
      ChecklistPageState();
}

class ChecklistPageState extends State<ChecklistPage> {
  final List<Map<String, dynamic>> checklist = [];

  // Called from global FAB action
  void addChecklistItem() {
    setState(() {
      checklist.add({
        "title": "Task ${checklist.length + 1}",
        "done": false,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checklist")),
      body: checklist.isEmpty
          ? const Center(
              child: Text(
                "No tasks yet. Tap + to add one!",
              ),
            )
          : ListView.builder(
              itemCount: checklist.length,
              itemBuilder: (context, index) {
                return ChecklistItem(
                  title: checklist[index]["title"],
                  done: checklist[index]["done"],
                  onChanged: (value) {
                    setState(() {
                      checklist[index]["done"] =
                          value ?? false;
                    });
                  },
                );
              },
            ),
    );
  }
}
