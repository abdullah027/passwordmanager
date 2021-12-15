import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      labelText: AppStrings.newPw + AppStrings.password,
                      controller: newPasswordController,
                      hintText: AppStrings.newPw + AppStrings.password,
                      inputType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: retypePasswordController,
                      hintText: AppStrings.retypePassword,
                      labelText: AppStrings.retypePassword,
                      obscureText: true,
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
                  AppNavigation.navigateReplacement(context, HomeScreen());
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
}
