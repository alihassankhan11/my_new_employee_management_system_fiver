import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_password_practice/values/lists.dart';
import 'package:flutter/material.dart';

class TaskCompleted extends StatefulWidget {
  const TaskCompleted({Key? key}) : super(key: key);

  @override
  State<TaskCompleted> createState() => _TaskCompletedState();
}

class _TaskCompletedState extends State<TaskCompleted> {
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
              if (data['task_percentage'] == 100) {
                return Column(
                  children: [
                    ListTile(
                      tileColor: Colors.blueGrey.shade200,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(data['title'].toString()),
                      subtitle: Text(data['description'].toString()),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ).toList(),
        );
      },
    );
  }
}
