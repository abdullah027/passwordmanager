import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwordmanager/services/firebase_auth.dart';
import 'package:passwordmanager/utilis/text_const.dart';

class DatabaseService {
  final String? uid;

  DatabaseService(this.uid);

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future addUserData(String username, String email, String phone) async {
    return await userCollection.doc(uid).set({
      "username": username,
      "email": email,
      "phone": phone,
    }, SetOptions(merge: true));
  }

  Future updateUserData(String fullName, String email, String phone) async {
    return await userCollection
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({
      "fullname": fullName,
      "email": email,
      "phone": phone,
    });
  }

  Future deleteUserData(index) async {
    await userCollection.doc(uid).delete();
  }

  Future deleteAccountData(index) async {
    List data = [];
    var docRef = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('accounts')
        .get();
    docRef.docs.forEach((element) {
      print(element.id);
      data.add(element.id);
    });
    await userCollection
        .doc(uid)
        .collection('accounts')
        .doc(data[index])
        .delete()
        .then((value) {
      Fluttertoast.showToast(msg: "Deleted Successfully");
    });
  }

  Future addAccountData({
    String? fullName,
    String? domain,
    String? email,
    String? password,
    String? category,
  }) async {
    final response = await userCollection.doc(uid).collection('accounts').add({
      "fullname": fullName,
      "domain": domain,
      "email": email,
      "password": password,
      "category": category,
    }).then((value) {
      Fluttertoast.showToast(msg: AppStrings.successfullyAdded);
    });
    print(response);
    return response;
  }
}
