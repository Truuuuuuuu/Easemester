class Task {
  String title;
  String description;
  bool done;

  Task({
    required this.title,
    required this.description,
    this.done = false,
  });
}
