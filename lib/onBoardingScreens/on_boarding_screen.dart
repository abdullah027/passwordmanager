import 'package:flutter/material.dart';
import 'package:passwordmanager/authScreens/log_in_register_screen.dart';
import 'package:passwordmanager/sharedWidgets/custom_blue_button.dart';
import 'package:passwordmanager/sharedWidgets/custom_rich_text.dart';
import 'package:passwordmanager/sharedWidgets/custom_text.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/asset_paths.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/text_const.dart';
import 'package:sizer/sizer.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Container(
            height: 100.h,
            width: 100.w,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(AssetPaths.ellipse),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            )),
            child: Column(
              children: [
                Image.asset(AssetPaths.backgroundImage),
                Expanded(
                  child: Container(
                    width: 100.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              width: 35.w,
                              child: const CustomRichText(
                                text: AppStrings.saveAndGenerateText,
                                colorText: AppStrings.password,
                                afterText: AppStrings.easily,
                                fontWeight: FontWeight.w900,
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 50.w,
                            child: CustomText(
                              title: AppStrings.onBoardingText,
                              fontSize: 12,
                              textColor: AppColors.greyText,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                         CustomBlueButton(
                           borderRadius: BorderRadius.circular(10),
                           onPressed: (){
                             AppNavigation.navigateReplacement(context,const LogInRegisterScreen());

                           },
                         ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              right: 10.w,
              top: 25.h,
              child: Image.asset(
                AssetPaths.message,
                height: 40,
              )),
          Positioned(
              left: 20.w,
              top: 10.h,
              child: Image.asset(
                AssetPaths.message3,
                height: 40,
              )),
          Positioned(
              left: 8.w,
              top: 30.h,
              child: Image.asset(
                AssetPaths.message2,
                height: 40,
              )),
        ],
      ),
    );
  }
}
