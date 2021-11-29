import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwordmanager/utilis/text_const.dart';

import '../firestore_database.dart';

class Account {
  String? fullName;
  String? id;
  String? domain;
  //String? icon;
  String? email;
  String? password;
  String? category;

  Account({
    this.fullName,
    this.id,
    this.domain,
    //this.icon,
    this.email,
    this.password,
    this.category,
  });
}

class AccountsProvider with ChangeNotifier {
  final List<Account> _items = [];

  List<Account> get items {
    return _items;
  }

  Future addAccount({Account? account, String? uid}) async {
    try {
      await DatabaseService(uid)
          .addAccountData(
        fullName: account?.fullName,
        domain: account?.domain,
        category: account?.category,
        email: account?.email,
        password: account?.password,
      );
      notifyListeners();
      Fluttertoast.showToast(msg: AppStrings.successfullyAdded);
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
