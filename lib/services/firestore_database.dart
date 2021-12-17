import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwordmanager/services/firebase_auth.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/text_const.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  //uid shows null??
  //has garbage value
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
    for (var element in docRef.docs) {
      print(element.id);
      data.add(element.id);
    }
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
    int? category,
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

  //uid causing issue
  Future<String?> uploadProfilePic(File chosenImage, String userID) async {
    String fileName = userID;

    Reference ref = FirebaseStorage.instance.ref().child('profilePics/$uid');
    UploadTask uploadPicture = ref.putFile(chosenImage);
    final response =
        await uploadPicture.then((task) => task.ref.getDownloadURL());

    setProfileUrl(profilePhoto: response, uid: userID);
    return response.toString();
  }

  void setProfileUrl({String? profilePhoto, String? uid}) async {
    await userCollection.doc(uid).set({
      "image": profilePhoto,
    }, SetOptions(merge: true)).then((value) {
      Fluttertoast.showToast(msg: AppStrings.uploadDone);
    });
  }
}
