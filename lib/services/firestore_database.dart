import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

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

  Future updateUserData(String username, String email, String phone) async {
    return await userCollection.doc(uid).update({
      "username": username,
      "email": email,
      "phone": phone,
    });
  }

  Future deleteUserData() async {
    await userCollection.doc(uid).delete();
  }
}
