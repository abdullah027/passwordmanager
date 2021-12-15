import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwordmanager/Models/account_model.dart';
import 'package:passwordmanager/utilis/text_const.dart';

import '../firestore_database.dart';

class AccountProvider extends ChangeNotifier {
  Accounts? _user;
  List<Accounts> _accounts = [];

  Accounts? get user => _user;

  List<Accounts> get accounts {
    return _accounts;
  }

  void setUser(Accounts? user) {
    _user = user;
    notifyListeners();
  }

  void restUserProvider() {
    _user = null;
    notifyListeners();
  }

  void fetchAccountsList(List data) {
    _accounts = [];
    for (var element in data) {
      _accounts.add(Accounts.fromDocument(element));
    }
    notifyListeners();
  }

  void addAccounts(
      {String? fullName,
      String? domain,
      String? email,
      String? password,
      String? category,
      String? uid}) {
    DatabaseService(uid)
        .addAccountData(
            fullName: fullName,
            domain: domain,
            email: email,
            password: password,
            category: category)
        .then((value) {
      _accounts.add(
        Accounts(
          fullName: fullName,
          domain: domain,
          email: email,
          password: password,
          category: category,
        ),
      );
      notifyListeners();
    });

    print(_accounts.length);
  }

  void deleteAccount(index, String uid) {
    print(_accounts.length);
    print(index);
    print(_accounts.length);
    DatabaseService(uid).deleteAccountData(index).then((_) {
      _accounts.removeAt(index);
      notifyListeners();
    });
  }
}
