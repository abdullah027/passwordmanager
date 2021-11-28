import 'package:flutter/foundation.dart';

import '../firestore_database.dart';
import '../firestore_database.dart';

class Account {
  String id;
  String domain;
  String icon;
  String email;
  String password;
  String category;

  Account({
    required this.id,
    required this.domain,
    required this.icon,
    required this.email,
    required this.password,
    required this.category,
  });
}

class AccountsProvider with ChangeNotifier {
  List<Account> _items = [];

  List<Account> get items {
    return _items;
  }

  void addAccount({Account? account, String? uid}) async {
    DatabaseService(uid)
        .addAccountData(
      icon: account!.icon,
      domain: account.domain,
      category: account.category,
      email: account.email,
      password: account.password,
    )
        .then((value) {
      _items.add(Account(
        id: value,
        domain: account.domain,
        icon: account.icon,
        email: account.email,
        password: account.password,
        category: account.category,
      ));
      notifyListeners();
    });
  }
}
