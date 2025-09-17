class TaskModel {
  String title;
  String description;
  bool done;

  TaskModel({
    required this.title,
    required this.description,
    this.done = false,
  });
}
