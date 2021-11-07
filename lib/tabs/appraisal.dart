import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Aporaisal extends StatefulWidget {
  const Aporaisal({Key? key}) : super(key: key);

  @override
  State<Aporaisal> createState() => _AporaisalState();
}

class _AporaisalState extends State<Aporaisal> {
  late FirebaseFirestore firebaseFirestore;
  late int counter;
  @override
  void initState() {
    firebaseFirestore = FirebaseFirestore.instance;
    counter = 0;
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
        bool? safdf = snapshot.data?.docs.every((element) {
          Map<String, dynamic> data = element.data() as Map<String, dynamic>;

          if (data['task_percentage'] == 100) {
            print('000000000000000000000000000000000000000000000000000');
            counter = counter + 1;
            return true;
          } else {
            print('111111111111111111111111111111111111111111111111111111111');
            counter = counter;
            return false;
          }
        });

        if (snapshot.hasError) {
          return const Text('something has wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loadding');
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 200.0,
              lineWidth: 13.0,
              animation: true,
              percent: counter / 100,
              center: new Text(
                counter.toString(),
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              footer: new Text(
                "",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.blueGrey.shade600,
            ),
            Text(
              'You are ${100 - counter} tasks away for promotion',
              style: TextStyle(
                fontSize: 22,
                color: Colors.blueGrey.shade800,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}
