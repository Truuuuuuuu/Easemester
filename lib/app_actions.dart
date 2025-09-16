import 'package:easemester_app/views/pages/notes_page.dart';
import 'package:flutter/material.dart';
import 'package:easemester_app/views/pages/checklist_page.dart';


// Keys to access pages
final GlobalKey<ChecklistPageState> checklistKey =
    GlobalKey<ChecklistPageState>();
final GlobalKey<NotesPageState> notesKey =
    GlobalKey<NotesPageState>();

void addHomeFile() {
  print("Add file on Home page triggered!");
}

void addNotesItem() {
  print("Add item on Notes page triggered!");
  notesKey.currentState?.addNote();
}

void addChecklistItem() {
  print("Add item on Checklist page triggered!");
  checklistKey.currentState?.addChecklistItem();
}