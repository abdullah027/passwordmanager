import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwordmanager/services/firebase_auth.dart';
import 'package:passwordmanager/sharedWidgets/custom_blue_button.dart';
import 'package:passwordmanager/sharedWidgets/custom_text.dart';
import 'package:passwordmanager/sharedWidgets/custom_text_field.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/asset_paths.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/text_const.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            AppNavigation.navigatorPop(context);
          },
          icon: const Icon(Icons.arrow_back_ios,color: AppColors.blueButtonColor,size: 18,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Image.asset(
                      AssetPaths.logo,
                      height: 80,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      title: AppStrings.signUp,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      title: AppStrings.welcomeText2,
                      textColor: Colors.black.withOpacity(0.5),
                      textAlign: TextAlign.center,
                      fontSize: 12,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      controller: userNameController,
                      hintText: AppStrings.username,
                      inputType: TextInputType.name
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: emailAddressController,
                      hintText: AppStrings.emailAddress,
                      textAlign: TextAlign.justify,
                      inputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: mobileNumberController,
                      hintText: AppStrings.mobileNumber,
                      textAlign: TextAlign.justify,
                      inputType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: passwordController,
                      hintText: AppStrings.password,
                      obscureText: true,
                      textAlign: TextAlign.justify,
                      inputType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: confirmPasswordController,
                      hintText: AppStrings.confirmPassword,
                      obscureText: true,
                      textAlign: TextAlign.justify,
                      inputType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: CustomBlueButton(
                borderRadius: BorderRadius.circular(10),
                onPressed: () {
                  if(userNameController.text.isEmpty || emailAddressController.text.isEmpty || mobileNumberController.text.isEmpty || passwordController.text.isEmpty || confirmPasswordController.text.isEmpty){
                    Fluttertoast.showToast(msg: AppStrings.fieldMissing, gravity: ToastGravity.TOP);
                  }
                  else if(passwordController.text != confirmPasswordController.text){
                    Fluttertoast.showToast(msg: AppStrings.passwordDoNotMatch, gravity: ToastGravity.TOP);
                  }
                  else{
                    AuthenticationService(_firebaseAuth).signUp(emailAddressController.text, userNameController.text, mobileNumberController.text, passwordController.text, context);
                  }

                },
                text: AppStrings.signUp,
                width: 100.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
