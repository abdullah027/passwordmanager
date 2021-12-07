import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwordmanager/Models/account_model.dart';
import 'package:passwordmanager/utilis/text_const.dart';

import '../firestore_database.dart';

class AccountProvider extends ChangeNotifier {
  Accounts? _user;
  List<Accounts> getAccounts = [];

  Accounts? get user => _user;

  void setUser(Accounts? user) {
    _user = user;
    notifyListeners();
  }

  void restUserProvider() {
    _user = null;
    notifyListeners();
  }

  void fetchAccountsList(List data) {
    getAccounts = [];
    for (var element in data) {
      getAccounts.add(Accounts.fromDocument(element));
    }
    notifyListeners();
  }
}
