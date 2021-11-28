import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwordmanager/Models/user_model.dart';
import 'package:passwordmanager/authScreens/log_in_register_screen.dart';
import 'package:passwordmanager/bottomBarScreens/home_screen.dart';
import 'package:passwordmanager/onBoardingScreens/on_boarding_screen.dart';
import 'package:passwordmanager/services/firebase_auth.dart';
import 'package:passwordmanager/services/local_storage.dart';
import 'package:passwordmanager/services/providers/user_provider.dart';
import 'package:passwordmanager/sharedWidgets/custom_text.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/asset_paths.dart';
import 'package:passwordmanager/utilis/text_const.dart';
import 'package:provider/src/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _splashTimer() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var user =
        await AuthenticationService(FirebaseAuth.instance).getCurrentUser();
    print(user);
    //print(localStorage.getUser()?.uid);
    return Timer(const Duration(seconds: 2), () async {
      if (user != null && user.emailVerified) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            userProvider.setUser(Users.fromDocument(documentSnapshot));
            AppNavigation.navigateReplacement(context, const HomeScreen());
          }
        });
      }
      else if(user == null || !user.emailVerified){
        AppNavigation.navigateReplacement(context, const LogInRegisterScreen());
      }
      else {
        AppNavigation.navigateReplacement(context, const LogInRegisterScreen());
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _splashTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetPaths.logo,
            height: 100,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                title: AppStrings.appName,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
