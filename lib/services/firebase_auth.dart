import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwordmanager/bottomBarScreens/home_screen.dart';
import 'package:passwordmanager/services/local_storage.dart';
import 'package:passwordmanager/services/providers/user_provider.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/text_const.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firestore_database.dart';

class AuthenticationService {
  User? user = FirebaseAuth.instance.currentUser;

  final FirebaseAuth firebaseAuth;

  AuthenticationService(this.firebaseAuth);

  Stream<User?> get authStateChanges => firebaseAuth.idTokenChanges();

  Future getCurrentUser() async {
    return firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(),
          gravity: ToastGravity.TOP,
          toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<String> signUp(String email, String username, String phone,
      String password, context) async {
    var userProvider = Provider.of<UserProvider>(context,listen: false);
    LocalStorage localStorage = LocalStorage();
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("user data");
      print(result);
      print(user);
      final uid = result.user!.uid;
      userProvider.setUser(user);
      //localStorage.setUser(user: user['USER']);
      await result.user!.reload();
      await DatabaseService(uid)
          .addUserData(username, email, phone)
          .then((value) {
        Fluttertoast.showToast(
            msg: "Signed up Successfully", gravity: ToastGravity.TOP);
        AppNavigation.navigateReplacement(context, const HomeScreen());
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(),
          gravity: ToastGravity.TOP,
          toastLength: Toast.LENGTH_LONG);
    }
    throw "";
  }

  Future<String> signIn(String email, String password,context) async {
    var userProvider = Provider.of<UserProvider>(context,listen: false);
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password).then((value) {
        userProvider.setUser(user);
        pref.setString('uid', user!.uid.toString());
        print("user data");
        print(user);
        AppNavigation.navigateTo(context, const HomeScreen());

      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(),
          gravity: ToastGravity.TOP,
          toastLength: Toast.LENGTH_LONG);
    }
    throw "";
  }
}
