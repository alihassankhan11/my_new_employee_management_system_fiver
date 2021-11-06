import 'package:email_password_practice/values/lists.dart';
import 'package:flutter/material.dart';

class TaskCompleted extends StatelessWidget {
  const TaskCompleted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: MyLists.completedTasks!.map<Widget>((title) {
        return ListTile(
          title: Text(title),
        );
      }).toList(),
    );
  }
}
