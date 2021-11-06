class EmployeeTask {
  String title;
  String description;
  int taskPercentage;
  EmployeeTask(
      {required this.description,
      required this.taskPercentage,
      required this.title});
  EmployeeTask.fromjson(Map<String, Object?> json)
      : this(
            title: json['title'] as String,
            description: json['description'] as String,
            taskPercentage: json['taskPercentage'] as int);
  Map<String, Object?> toJson() {
    return {
      'title': title,
      'description': description,
      'taskPercentage': taskPercentage,
    };
  }
}
