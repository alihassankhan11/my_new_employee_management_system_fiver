import 'package:email_password_practice/routes/navigation.dart';
import 'package:email_password_practice/screens/home.dart';
import 'package:email_password_practice/values/custom_snack_bar.dart';
import 'package:email_password_practice/values/decoration.dart';
import 'package:email_password_practice/values/string.dart';
import 'package:email_password_practice/widgets/button.dart';
import 'package:email_password_practice/widgets/spacer.dart';
import 'package:email_password_practice/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late Size size;
  late Size size2;
  var email = '';
  var password = '';
  var firebaseAuth = FirebaseAuth.instance;
  void signUpWithEmailPassword() async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      CustomSnackBar.showSnackBar('account create and login', context);
      NavigationTo.pushAndRemoveUntil(
          Home(email: email, name: password), context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomSnackBar.showSnackBar('weak password', context);
      } else if (e.code == 'email-already-in-use') {
        CustomSnackBar.showSnackBar('email-already-in-use', context);
      } else if (e.code == 'invalid-email') {
        CustomSnackBar.showSnackBar('invalid-email', context);
      } else {
        CustomSnackBar.showSnackBar('operation-not-allowed', context);
      }
    } catch (e) {
      CustomSnackBar.showSnackBar(e.toString(), context);
    }
  }

  @override
  void didChangeDependencies() {
    size = Size(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height - 86);
    size2 = Size(MediaQuery.of(context).size.width, 100);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(StringConst.SIGN_UP),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: Decorations.boxDecorationForEntireScreen(),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            StringConst.SIGN_UP,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          MySpacer(size: size),

          //email
          MyTextField(text: 'Name', size: size, onChanged: (_) {}),
          MySpacer(
            size: size,
            heightFactor: 0.01,
          ),
          //phone

          MyTextField(
              text: 'Email',
              size: size,
              onChanged: (value) {
                email = value;
              }),
          MySpacer(
            size: size,
            heightFactor: 0.01,
          ),
          MyTextField(text: 'Phone', size: size, onChanged: (_) {}),
          MySpacer(
            size: size,
            heightFactor: 0.01,
          ),
          MyTextField(text: 'Designation', size: size, onChanged: (_) {}),
          MySpacer(
            size: size,
            heightFactor: 0.01,
          ),
          MyTextField(
              text: 'Password',
              size: size,
              onChanged: (value) {
                password = value;
              }),
          MySpacer(size: size),
          //sign up
          CustomButton(
            bgColor: Colors.blue,
            text: StringConst.SIGN_UP,
            size: size,
            onPressed: signUpWithEmailPassword,
          ),
          MySpacer(
            size: size,
            heightFactor: 0.01,
          ),
          Container(alignment: Alignment.centerLeft, child: lastLine()),
        ]),
      ),
    );
  }

  ///
//   Other option if already have an account
  ///
  Widget lastLine() {
    return GestureDetector(
      onTap: () {
        NavigationTo.push(const SignIn(), context);
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(text: StringConst.ALREADY_HAVE_ACCOUNT),
            TextSpan(
              text: ' ${StringConst.SIGN_IN}',
              style: TextStyle(color: Colors.black87, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
