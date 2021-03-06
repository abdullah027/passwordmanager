import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwordmanager/Models/user_model.dart';
import 'package:passwordmanager/authScreens/login_screen.dart';
import 'package:passwordmanager/authScreens/verification_screen.dart';
import 'package:passwordmanager/bottomBarScreens/home_screen.dart';
import 'package:passwordmanager/services/local_storage.dart';
import 'package:passwordmanager/services/providers/account_provider.dart';
import 'package:passwordmanager/services/providers/user_provider.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/text_const.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firestore_database.dart';

class AuthenticationService {
  Users? user;

  final FirebaseAuth firebaseAuth;

  AuthenticationService(this.firebaseAuth);

  //Stream<User?> get authStateChanges => firebaseAuth.idTokenChanges();

  Future<User?> getCurrentUser() async {
    return firebaseAuth.currentUser;
  }

  Users? _userFromFirebaseUser(User? user) {
    return user != null ? Users(id: user.uid, email: user.email) : null;
  }

  Future<void> signOut(context) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      var accountProvider = Provider.of<AccountProvider>(context, listen: false);
      accountProvider.restUserProvider();
      userProvider.restUserProvider();
      await firebaseAuth.signOut().then((value) => {
            AppNavigation.navigateReplacement(context, const LogInScreen()),
          });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(),
          gravity: ToastGravity.TOP,
          toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<String> signUp(String email, String username, String phone,
      String password, context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    LocalStorage localStorage = LocalStorage();
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      //localStorage.setUser(user: user['USER']);
      await user!.reload();
      Users? data = _userFromFirebaseUser(user);
      userProvider.setUser(data);
      await DatabaseService(user.uid)
          .addUserData(username, email, phone)
          .then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            userProvider.setUser(Users.fromDocument(documentSnapshot));
          }
        });
        Fluttertoast.showToast(
            msg: "Signed up Successfully", gravity: ToastGravity.TOP);
        AppNavigation.navigateReplacement(context, const VerificationScreen());
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(),
          gravity: ToastGravity.TOP,
          toastLength: Toast.LENGTH_LONG);
    }
    throw "";
  }

  Future<String> signIn(String email, String password, context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print("Value: " + value.toString());
        User? user = value.user;
        Users? data = _userFromFirebaseUser(user);
        userProvider.setUser(data);
        FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            userProvider.setUser(Users.fromDocument(documentSnapshot));
          }
        });
        //userProvider.setUser(Users.fromDocument(doc));
        AppNavigation.navigateReplacement(context, const HomeScreen());
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(),
          gravity: ToastGravity.TOP,
          toastLength: Toast.LENGTH_LONG);
    }
    throw "";
  }

  Future resetPassword (String email, context) async{
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
        AppNavigation.navigateReplacement(context, const LogInScreen());
        Fluttertoast.showToast(msg: AppStrings.passwordResetEmail);
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }

  Future updateUser(fullName, email, phone, context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      print(fullName);
      await DatabaseService(FirebaseAuth.instance.currentUser?.uid)
          .updateUserData(fullName, email, phone)
          .then((value) => {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .get()
                    .then((DocumentSnapshot documentSnapshot) {
                  if (documentSnapshot.exists) {
                    userProvider.setUser(Users.fromDocument(documentSnapshot));
                    //LocalStorage().setUser(user: documentSnapshot.data().toString());
                  }
                }),
                Fluttertoast.showToast(msg: AppStrings.successfullyUpdated)
              });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }

  Future<List<Object?>> getAccounts(context) async {
    var accountProvider = Provider.of<AccountProvider>(context, listen: false);
    final CollectionReference _collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('accounts');
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final data = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(data);
    accountProvider.fetchAccountsList(data);


    return data;
  }
}
