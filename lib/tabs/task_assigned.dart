// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskAssigned extends StatefulWidget {
  const TaskAssigned({Key? key}) : super(key: key);

  @override
  State<TaskAssigned> createState() => _TaskAssignedState();
}

class _TaskAssignedState extends State<TaskAssigned> {
  late FirebaseFirestore firebaseFirestore;
  @override
  void initState() {
    firebaseFirestore = FirebaseFirestore.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('task assigned');

    Stream<QuerySnapshot> taskAssigned =
        FirebaseFirestore.instance.collection('task assigned').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: taskAssigned,
      builder: (context, snapshot) {
        var listWidget = <Widget>[];
        if (snapshot.hasError) {
          return const Text('something has wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loadding');
        }
        return ListView(
          children: snapshot.data!.docs.map<Widget>(
            (DocumentSnapshot documentSnapshot) {
              // feild data of the documnet
              Map<String, dynamic> data =
                  documentSnapshot.data() as Map<String, dynamic>;
              // builder list of widget
              return ListTile(
                title: Text(data['title'].toString()),
                subtitle: Text(data['description'].toString()),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      Text(data['task_percentage'].toString()),
                      ElevatedButton(
                          onPressed: data['task_percentage'] == 100
                              ? null
                              : () {
                                  collectionReference
                                      .doc(documentSnapshot.id)
                                      .update(
                                    {
                                      'task_percentage':
                                          data['task_percentage'] + 10,
                                    },
                                  );
                                },
                          child: const Text('add')),
                    ],
                  ),
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
