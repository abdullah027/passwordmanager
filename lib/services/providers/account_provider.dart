import 'package:flutter/foundation.dart';
import 'package:passwordmanager/Models/account_model.dart';
import '../firestore_database.dart';

class AccountProvider extends ChangeNotifier {
  Accounts? _account;
  List<Accounts> _accounts = [];

  Accounts? get account => _account;

  List<Accounts> get accounts {
    return _accounts;
  }

  void setAccount(Accounts? account) {
    _account = account;
    notifyListeners();
  }

  void restUserProvider() {
    _account = null;
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
      int? category,
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
