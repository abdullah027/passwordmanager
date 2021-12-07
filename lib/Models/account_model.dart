import 'package:cloud_firestore/cloud_firestore.dart';

class Accounts{

  String? fullName;
  String? id;
  String? domain;
  //String? icon;
  String? email;
  String? password;
  String? category;

  Accounts({
    this.fullName,
    this.id,
    this.domain,
    //this.icon,
    this.email,
    this.password,
    this.category,
  });

  factory Accounts.fromDocument(Map<String, dynamic> doc){
    return Accounts(
        id: doc['id'],
        email: doc['email'],
        domain: doc['domain'],
        fullName: doc['fullname'],
        password: doc['password']
    );
  }
}