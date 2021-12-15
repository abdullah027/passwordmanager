import 'package:flutter/material.dart';
import 'package:passwordmanager/authScreens/otp_screen.dart';
import 'package:passwordmanager/sharedWidgets/custom_blue_button.dart';
import 'package:passwordmanager/sharedWidgets/custom_text.dart';
import 'package:passwordmanager/sharedWidgets/custom_text_field.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/asset_paths.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/text_const.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class ForGotPasswordScreen extends StatefulWidget {
  const ForGotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForGotPasswordScreenState createState() => _ForGotPasswordScreenState();
}

class _ForGotPasswordScreenState extends State<ForGotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

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
              size: 18,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetPaths.lock,
                        height: 120,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomText(
                        title: AppStrings.forgotPasswordText,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        title: AppStrings.emailInfo,
                        textColor: Colors.black.withOpacity(0.5),
                        textAlign: TextAlign.center,
                        fontSize: 12,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                          controller: emailController,
                          hintText: AppStrings.enterYourEmail,
                          inputType: TextInputType.name),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                        },
                        child: Container(
                          padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          child: CustomText(
                            title: AppStrings.tryAnotherWays,
                            fontSize: 12,
                            textColor: AppColors.blueButtonColor,
                          ),
                        ),
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
                    AppNavigation.navigateReplacement(context, const OtpScreen());
                  },
                  text: AppStrings.resetPassword,
                  width: 100.w,
                ),
              ),
            ],
          ),
        ));
  }
}
