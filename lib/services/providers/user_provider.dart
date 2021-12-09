import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:passwordmanager/Models/user_model.dart';
import '../firestore_database.dart';

class UserProvider extends ChangeNotifier {
  Users? _user;
  String? _profileImagePath;

  Users? get user => _user;

  void setUser(Users? user) {
    _user = user;
    notifyListeners();
  }

  String? get profileImage {
    return _profileImagePath;
  }

  void setProfilePic(File chosenImage, String uid) async {
    _profileImagePath =
        await DatabaseService(_user?.id).uploadProfilePic(chosenImage, uid);
    _user?.image = _profileImagePath;
    notifyListeners();
  }

  void restUserProvider() {
    _user = null;
    notifyListeners();
  }
}
