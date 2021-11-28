import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwordmanager/bottomBarScreens/home_screen.dart';
import 'package:passwordmanager/sharedWidgets/custom_text.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/text_const.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    user = auth.currentUser;
    sendEmailVerification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CustomText(
                title: AppStrings.verifyText,
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: CustomText(
                title: AppStrings.verifyEmailText +
                    "${user?.email}" +
                    AppStrings.verifyEmailText2,
                textColor: Colors.black.withOpacity(0.5),
                textAlign: TextAlign.center,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendEmailVerification() async {
    try {
      setState(() {
        user?.sendEmailVerification().whenComplete(() {
          Fluttertoast.showToast(msg: "Email has been sent");
          checkEmailVerified();
        });
      });
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user?.reload();
    if (user!.emailVerified) {
      AppNavigation.navigateReplacement(context, const HomeScreen());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
