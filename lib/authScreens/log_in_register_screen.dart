import 'package:flutter/material.dart';
import 'package:passwordmanager/authScreens/sign_up_screen.dart';
import 'package:passwordmanager/sharedWidgets/custom_blue_button.dart';
import 'package:passwordmanager/sharedWidgets/custom_text.dart';
import 'package:passwordmanager/sharedWidgets/custom_white_button.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/asset_paths.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/text_const.dart';
import 'package:sizer/sizer.dart';

import 'login_screen.dart';

class LogInRegisterScreen extends StatefulWidget {
  const LogInRegisterScreen({Key? key}) : super(key: key);

  @override
  _LogInRegisterScreenState createState() => _LogInRegisterScreenState();
}

class _LogInRegisterScreenState extends State<LogInRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Expanded(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        title: AppStrings.letsSavePasswords,
                        fontSize: 16,
                        textColor: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 0,
              child: Column(
                children: [
                  _logInButton(),
                  const SizedBox(
                    height: 20,
                  ),
                  _registerButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _logInButton() {
    return CustomWhiteButton(
      onPressed: () {
        AppNavigation.navigateTo(context, const LogInScreen());
      },
      text: AppStrings.logIn,
      textColor: AppColors.logInTextColor,
    );
  }

  Widget _registerButton() {
    return CustomBlueButton(
      width: 80.w,
      text: AppStrings.register,
      onPressed: () {
        AppNavigation.navigateTo(context, const SignUpScreen());
      },

    );
  }
}
