import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:passwordmanager/Models/user_model.dart';
import 'package:passwordmanager/services/firebase_auth.dart';
import 'package:passwordmanager/services/google_sign_in.dart';
import 'package:passwordmanager/services/providers/account_provider.dart';
import 'package:passwordmanager/services/providers/user_provider.dart';
import 'package:passwordmanager/splashScreen/splash_screen.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/them_changer.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'authScreens/log_in_register_screen.dart';
import 'bottomBarScreens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (_) => ThemeChanger(ThemeMode.light)),
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        ChangeNotifierProvider(
          create: (_) => AccountProvider(),
        ),
      ],
      child: Sizer(builder: (context, orientation, type) {
        final theme = Provider.of<ThemeChanger>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: theme.getTheme(),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: AppColors.scaffoldColor2,
            fontFamily: 'Mulish',
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
                elevation: 0, backgroundColor: AppColors.scaffoldColor2),
          ),
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.scaffoldColor,
            fontFamily: 'Mulish',
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
                elevation: 0, backgroundColor: AppColors.scaffoldColor),
          ),
          home: const SplashScreen(),
        );
      }),
    );
  }
}
