import 'package:firebase_auth/firebase_auth.dart';
import 'package:passwordmanager/Models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static LocalStorage? _sharedPreferenceHelper;
  static SharedPreferences? _sharedPreferences;

  LocalStorage._createInstance();

  factory LocalStorage() {
    // factory with constructor, return some value
    _sharedPreferenceHelper ??= LocalStorage
          ._createInstance();
    return _sharedPreferenceHelper!;
  }

  Future<SharedPreferences> get sharedPreference async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  ///-------------------- Clear Preference -------------------- ///
  void clear() {
    _sharedPreferences?.clear();
  }


  ///-------------------- User -------------------- ///
  void setUser({String? user}) {
    _sharedPreferences?.setString('User', user ?? '');
  }

  Users? getUser() {
    if (_sharedPreferences?.getString('User') == null) {
      return null;
    } else {
      Users user = (_sharedPreferences!.getString('User') ?? '') as Users;
      return user;
    }
  }


}
