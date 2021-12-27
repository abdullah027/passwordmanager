import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwordmanager/bottomBarScreens/home_screen.dart';
import 'package:passwordmanager/sharedWidgets/custom_blue_button.dart';
import 'package:passwordmanager/sharedWidgets/custom_rich_text.dart';
import 'package:passwordmanager/sharedWidgets/custom_text.dart';
import 'package:passwordmanager/sharedWidgets/custom_text_field.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/text_const.dart';
import 'package:sizer/sizer.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();

  bool isSelected = true;
  bool isSelected1 = true;
  bool isSelected2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              AppNavigation.navigatorPop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.blueButtonColor,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomRichText(
                      colorText: AppStrings.newPw,
                      colorTextColor: AppColors.blueButtonColor,
                      afterText: AppStrings.password,
                      fontWeight: FontWeight.w900,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      title: AppStrings.newPasswordText,
                      textColor: Colors.black.withOpacity(0.5),
                      textAlign: TextAlign.center,
                      fontSize: 12,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      labelText: AppStrings.oldPw + AppStrings.password,
                      controller: oldPasswordController,
                      hintText: AppStrings.oldPw + AppStrings.password,
                      inputType: TextInputType.visiblePassword,
                      obscureText: isSelected,
                      suffixIcon: isSelected == false?const Icon(CupertinoIcons.eye):const Icon(CupertinoIcons.eye_slash),
                      onPressed: (){
                        setState(() {
                          isSelected = !isSelected;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      labelText: AppStrings.newPw + AppStrings.password,
                      controller: newPasswordController,
                      hintText: AppStrings.newPw + AppStrings.password,
                      inputType: TextInputType.visiblePassword,
                      obscureText: isSelected1,
                      suffixIcon: isSelected1 == false?const Icon(CupertinoIcons.eye):const Icon(CupertinoIcons.eye_slash),
                      onPressed: (){
                        setState(() {
                          isSelected1 = !isSelected1;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: retypePasswordController,
                      hintText: AppStrings.retypePassword,
                      labelText: AppStrings.retypePassword,
                      obscureText: isSelected2,
                      suffixIcon: isSelected2 == false?const Icon(CupertinoIcons.eye):const Icon(CupertinoIcons.eye_slash),
                      onPressed: (){
                        setState(() {
                          isSelected2 = !isSelected2;
                        });
                      },
                      textAlign: TextAlign.justify,
                      inputType: TextInputType.visiblePassword,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: CustomBlueButton(
                onPressed: () {
                  if (newPasswordController.text !=
                      retypePasswordController.text) {
                    Fluttertoast.showToast(msg: AppStrings.passwordDoNotMatch);
                  } else {
                    _changePassword(oldPasswordController.text,
                        retypePasswordController.text);
                  }
                },
                width: 100.w,
                text: AppStrings.confirm,
                borderRadius: BorderRadius.circular(10),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _changePassword(String currentPassword, String newPassword) async {
    final user = await FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user!.email!, password: currentPassword);

    user.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) {
        Fluttertoast.showToast(msg: AppStrings.successfullyUpdated);
        AppNavigation.navigateReplacement(context, HomeScreen());
      }).catchError((error) {
        Fluttertoast.showToast(msg: error);
      });
    }).catchError((err) {});
  }
}
