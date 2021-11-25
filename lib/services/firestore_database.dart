import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    return await userCollection.doc(FirebaseAuth.instance.currentUser?.uid).update({
      "fullname": fullName,
      "email": email,
      "phone": phone,
    });
  }

  Future deleteUserData() async {
    await userCollection.doc(uid).delete();
  }
}
