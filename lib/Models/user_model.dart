import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String? id;
  final String? fullName;
  final String? userName;
  String? image;
  final String? email;
  final String? phone;

  Users(
      {this.id,
      this.image,
      this.userName,
      this.phone,
      this.email,
      this.fullName});

  factory Users.fromDocument(DocumentSnapshot doc) {
    return Users(
        id: (doc.data() as dynamic)['id'],
        email: (doc.data() as dynamic)['email'],
        userName: (doc.data() as dynamic)['username'],
        phone: (doc.data() as dynamic)['phone'],
        fullName: (doc.data() as dynamic)['fullname'],
        image: (doc.data() as dynamic)['image']);
  }
}
