
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:passwordmanager/bottomBarScreens/home_screen.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:provider/provider.dart';

class GoogleSignInProvider extends ChangeNotifier{
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogIn(context) async {
    final googleUser = await googleSignIn.signIn();
    if(googleUser == null){
      return;
    }
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    AppNavigation.navigateReplacement(context, HomeScreen());

    notifyListeners();

  }


}