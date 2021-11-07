import 'package:email_password_practice/routes/navigation.dart';
import 'package:email_password_practice/screens/home.dart';
import 'package:email_password_practice/values/custom_snack_bar.dart';
import 'package:email_password_practice/widgets/button.dart';
import 'package:email_password_practice/widgets/spacer.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Size size;
  User? user = FirebaseAuth.instance.currentUser;
  String userEmail = '';
  String userPassword = '';
  late TextEditingController textEditingControllerEmail;
  @override
  void initState() {
    if (user != null) {
      userEmail = user!.email!;
    }

    textEditingControllerEmail = TextEditingController(text: userEmail);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    size = Size(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height - 86);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 160,
              width: 160,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage('assets/images/avatar.png'),
                ),
              ),
            ),
            MySpacer(
              size: size,
              heightFactor: 0.02,
            ),
            //email
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextField(
                controller: textEditingControllerEmail,
                onChanged: (value) {},
                cursorColor: Colors.blue,
                cursorHeight: 30,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.blue),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
              ),
            ),
            //password
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextField(
                onChanged: (value) {
                  userPassword = value;
                },
                cursorColor: Colors.blue,
                cursorHeight: 30,
                decoration: const InputDecoration(
                  labelText: 'password',
                  labelStyle: TextStyle(color: Colors.blue),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
              ),
            ),
            MySpacer(
              size: size,
              heightFactor: 0.02,
            ),
            CustomButton(
              bgColor: Colors.blue,
              text: 'update password',
              size: size,
              onPressed: () async {
                if (userPassword.isNotEmpty) {
                  await user!.updatePassword(userPassword);
                  CustomSnackBar.showSnackBar('password updated', context);
                  NavigationTo.pushAndRemoveUntil(
                      Home(email: userEmail, name: userPassword), context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
