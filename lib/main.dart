import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:passwordmanager/Models/user_model.dart';
import 'package:passwordmanager/services/firebase_auth.dart';
import 'package:passwordmanager/services/providers/user_provider.dart';
import 'package:passwordmanager/splashScreen/splash_screen.dart';
import 'package:passwordmanager/utilis/color_const.dart';
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
    bool _isDark = false;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance)),
      ],
      child: Sizer(builder: (context, orientation, type) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
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
          themeMode: _isDark == true ? ThemeMode.dark : ThemeMode.light,
          home: const SplashScreen(),
        );
      }),
    );
  }
}
