import 'package:flutter/material.dart';
import 'package:passwordmanager/authScreens/new_password_screen.dart';
import 'package:passwordmanager/sharedWidgets/custom_blue_button.dart';
import 'package:passwordmanager/sharedWidgets/custom_text.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/asset_paths.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/text_const.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

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
                        AssetPaths.email,
                        height: 120,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomText(
                        title: AppStrings.verifyText,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        title: AppStrings.verifyDescText,
                        textColor: Colors.black.withOpacity(0.5),
                        textAlign: TextAlign.center,
                        fontSize: 12,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: PinCodeTextField(
                          maxLength: 4,
                          controller: otpController,
                          pinBoxWidth: MediaQuery.of(context).size.width * 0.13,
                          pinBoxHeight: 55,
                          keyboardType: TextInputType.number,
                          pinBoxRadius: 10,
                          pinBoxBorderWidth: 2,
                          pinBoxColor: AppColors.scaffoldColor,
                          defaultBorderColor:
                              AppColors.greyText.withOpacity(0.09),
                          highlightPinBoxColor: AppColors.blueText,
                          hasTextBorderColor:
                              AppColors.blueButtonColor.withOpacity(0.2),
                          highlightAnimation: true,
                          hasUnderline: false,
                          highlight: true,
                          pinTextAnimatedSwitcherDuration:
                              const Duration(milliseconds: 200),
                          highlightColor: AppColors.blueButtonColor,
                          pinTextStyle: const TextStyle(
                              fontSize: 20, color: AppColors.scaffoldColor),
                          onDone: (String str) {
                            if (otpController.text == str) {
                              //AppNavigation.navigateReplacement(context, BottomBarScreen());
                            }
                          },
                          onTextChanged: (String str) {},
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: CustomText(
                            title: AppStrings.resendCode,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
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
                    AppNavigation.navigateReplacement(context, const NewPasswordScreen());
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
