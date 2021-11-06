import 'package:email_password_practice/routes/navigation.dart';
import 'package:email_password_practice/tabs/task_assigned.dart';
import 'package:email_password_practice/values/custom_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'sign_in_screens/sign_in.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.email, required this.name})
      : super(key: key);
  final String name;
  final String email;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Task asigned',
              ),
              Tab(
                text: 'Completed tasks',
              ),
              Tab(
                text: 'Apraisal',
              )
            ],
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) async {
                switch (value) {
                  case 'Logout':
                    {
                      try {
                        await firebaseAuth.signOut();
                        firebaseAuth.authStateChanges().listen(
                          (User? user) {
                            if (user == null) {
                              NavigationTo.pushAndRemoveUntil(
                                  const SignIn(), context);
                              CustomSnackBar.showSnackBar(
                                  'user is logout', context);
                            } else {
                              CustomSnackBar.showSnackBar(
                                  'User is signed in', context);
                            }
                          },
                        );
                      } on FirebaseAuthException catch (e) {
                        CustomSnackBar.showSnackBar(
                            e.message ?? e.code, context);
                      }

                      CustomSnackBar.showSnackBar('Click logout', context);
                      break;
                    }
                  case 'Settings':
                    {
                      CustomSnackBar.showSnackBar('Click Settings', context);
                      break;
                    }
                }
              },
              itemBuilder: (BuildContext context) {
                return {'Logout', 'Settings'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            const TaskAssigned(),
            Container(
              color: Colors.yellow,
            ),
            Container(
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
