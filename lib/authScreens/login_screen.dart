import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passwordmanager/authScreens/forgot_password_screen.dart';
import 'package:passwordmanager/authScreens/sign_up_screen.dart';
import 'package:passwordmanager/bottomBarScreens/home_screen.dart';
import 'package:passwordmanager/services/firebase_auth.dart';
import 'package:passwordmanager/services/google_sign_in.dart';
import 'package:passwordmanager/sharedWidgets/custom_blue_button.dart';
import 'package:passwordmanager/sharedWidgets/custom_text.dart';
import 'package:passwordmanager/sharedWidgets/custom_text_field.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/asset_paths.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/text_const.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool isSelected = true;

  @override
  void initState() {
    emailController.text = 'mal9627.ma@gmail.com';
    passwordController.text = 'Waiter!4321';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AssetPaths.logo,
                height: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomText(
                title: AppStrings.helloWelcome,
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomText(
                title: AppStrings.welcomeText,
                textColor: Colors.black.withOpacity(0.5),
                textAlign: TextAlign.center,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: emailController,
                hintText: AppStrings.enterYourEmail,
                inputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: passwordController,
                hintText: AppStrings.password,
                obscureText: isSelected,
                suffixIcon: isSelected == false?const Icon(CupertinoIcons.eye):const Icon(CupertinoIcons.eye_slash),
                onPressed: (){
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                textAlign: TextAlign.justify,
                inputType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  AppNavigation.navigateTo(context, const ForGotPasswordScreen());
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: CustomText(
                    title: AppStrings.forgotPasswordText,
                    textColor: AppColors.blackUtamaColor,
                    fontSize: 12,
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomBlueButton(
                borderRadius: BorderRadius.circular(10),
                onPressed: () {
                  AuthenticationService(firebaseAuth).signIn(emailController.text, passwordController.text,context);
                },
                text: AppStrings.logIn,
                width: 100.w,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    title: AppStrings.noAccountText,
                    fontSize: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      AppNavigation.navigateTo(context, const SignUpScreen());
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: CustomText(
                        title: AppStrings.signUp,
                        fontSize: 12,
                        textColor: AppColors.blueButtonColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomText(
                title: AppStrings.orText,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      final googleSignInProvider = Provider.of<GoogleSignInProvider>(context,listen:false);
                      googleSignInProvider.googleLogIn(context);
                    },
                    child: Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(width: 1.5,color: AppColors.borderColor),
                        ),
                        child: Image.asset(AssetPaths.google,height: 15,),),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(width: 1.5,color: AppColors.borderColor),
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.facebookF,
                        size: 18,
                        color: Colors.blue,
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: (){
                  AppNavigation.navigateTo(context, const HomeScreen());
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child: CustomText(
                    title: AppStrings.skipText,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
