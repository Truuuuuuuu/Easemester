import 'package:flutter/material.dart';
import '../../../controllers/notes_controller.dart';

class AddNoteFormPage extends StatefulWidget {
  final NotesController controller;

  const AddNoteFormPage({
    super.key,
    required this.controller,
  });

  @override
  State<AddNoteFormPage> createState() =>
      _AddNoteFormPageState();
}

class _AddNoteFormPageState extends State<AddNoteFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      widget.controller.addNote(
        _titleController.text.trim(),
        _contentController.text.trim(),
      );
      Navigator.pop(context); // go back to NotesPage
    }
  }

  InputDecoration _inputDecoration(
    String hint,
    BuildContext context,
  ) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return InputDecoration(
      hintText: hint,
      filled: true,
      isDense: true,
      fillColor: isDark
          ? const Color(0xFF2C2C2C) // dark grey
          : const Color.fromARGB(
              255,
              242,
              242,
              242,
            ), // light grey
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title",
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _titleController,
                decoration: _inputDecoration(
                  "Enter note title",
                  context,
                ),
                validator: (value) =>
                    value == null || value.isEmpty
                    ? "Enter a title"
                    : null,
              ),
              const SizedBox(height: 20),

              Text(
                "Content",
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _contentController,
                maxLines: 6,
                decoration: _inputDecoration(
                  "Write your note here...",
                  context,
                ),
              ),

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveNote,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                    backgroundColor:
                        theme.colorScheme.primary,
                  ),
                  icon: Icon(
                    Icons.save,
                    size: 22,
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary,
                  ),
                  label: Text(
                    "Save Note",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
