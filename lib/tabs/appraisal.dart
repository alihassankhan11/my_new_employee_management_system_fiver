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
  int counter = 0;
  Stream<QuerySnapshot> taskAssigned =
      FirebaseFirestore.instance.collection('task assigned').snapshots();
  late Map<String, dynamic> data;
  @override
  void didChangeDependencies() {
    firebaseFirestore = FirebaseFirestore.instance;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: taskAssigned,
      builder: (context, snapshot) {
        print('000000000000000000000000000000000000000000000000000000');
        if (snapshot.hasError) {
          return const Text('something has wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loadding');
        }

        snapshot.data?.docs.every(
          (element) {
            data = element.data() as Map<String, dynamic>;
            print('..................................................');
            if (data['task_percentage'] == 100) {
              counter = counter + 1;

              return true;
            } else {
              counter = counter;
              return false;
            }
          },
        );

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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              footer: Text(
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
