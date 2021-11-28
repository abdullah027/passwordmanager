import 'dart:math';

import 'package:flutter/material.dart';
import 'package:passwordmanager/sharedWidgets/bottom_navigation_bar.dart';
import 'package:passwordmanager/sharedWidgets/custom_blue_button.dart';
import 'package:passwordmanager/sharedWidgets/custom_text.dart';
import 'package:passwordmanager/sharedWidgets/custom_text_field.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/text_const.dart';
import 'package:sizer/sizer.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:password_strength/password_strength.dart';

import 'add_account_screen.dart';

enum _PassWordType { normal, strong, veryStrong }

class GeneratePasswordScreen extends StatefulWidget {
  const GeneratePasswordScreen({Key? key}) : super(key: key);

  @override
  _GeneratePasswordScreenState createState() => _GeneratePasswordScreenState();
}

class _GeneratePasswordScreenState extends State<GeneratePasswordScreen> {
  final TextEditingController _controller = TextEditingController();
  double? strength;

  _PassWordType? _passwordType = _PassWordType.strong;
  bool? isSelected;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            AppNavigation.navigateTo(context, const AddAccountScreen());
          });
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavBar(
        index: 2,
      ),
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          title: AppStrings.generatePassword,
          fontWeight: FontWeight.w900,
          fontSize: 16,
          textColor: AppColors.appBarIconColor,
        ),
        leading: IconButton(
          onPressed: () {
            AppNavigation.navigatorPop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.appBarIconColor,
            size: 20,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: AppColors.appBarIconColor,
                size: 20,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Center(
                      child: SleekCircularSlider(
                        max: 100,
                        min: 0,
                        initialValue: strength == null?10:strength!*100,
                        appearance: CircularSliderAppearance(
                          infoProperties: InfoProperties(
                            mainLabelStyle: const TextStyle(
                                color: AppColors.blueButtonColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            bottomLabelText: "Strong",
                            bottomLabelStyle: const TextStyle(
                                color: AppColors.blueButtonColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                          angleRange: 360,
                          counterClockwise: true,
                          startAngle: -100,
                          size: 120,
                          customWidths: CustomSliderWidths(
                              handlerSize: 0,
                              shadowWidth: 0,
                              trackWidth: 0,
                              progressBarWidth: 5),
                          customColors: CustomSliderColors(
                            dynamicGradient: false,
                            progressBarColor: AppColors.blueButtonColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowColor.withOpacity(0.21),
                              blurRadius: 54,
                              offset: const Offset(2, 2),
                            ),
                          ]),
                      child: CustomTextField(
                        controller: _controller,
                        fillColor: AppColors.scaffoldColor,
                        enabled: false,
                        borderSide: BorderSide.none,


                      )
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          title: AppStrings.normal,
                          fontWeight: FontWeight.w900,
                        ),
                        Radio(
                            value: _PassWordType.normal,
                            groupValue: _passwordType,
                            onChanged: (_PassWordType? val) {
                              setState(() {
                                _passwordType = val;
                              });
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            title: AppStrings.strong, fontWeight: FontWeight.w900),
                        Radio(
                            value: _PassWordType.strong,
                            groupValue: _passwordType,
                            onChanged: (_PassWordType? val) {
                              setState(() {
                                _passwordType = val;
                              });
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            title: AppStrings.veryStrong, fontWeight: FontWeight.w900),
                        Radio(
                            value: _PassWordType.veryStrong,
                            groupValue: _passwordType,
                            onChanged: (_PassWordType? val) {
                              setState(() {
                                _passwordType = val;
                              });
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(flex: 0,child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CustomBlueButton(
                borderRadius: BorderRadius.circular(10),
                width: 100.w,
                onPressed: (){
                  setState(() {
                    final password = generatePassword(normal: true,strong: _passwordType == _PassWordType.strong?true:false,veryStrong: _passwordType == _PassWordType.veryStrong?true:false );
                    strength = estimatePasswordStrength(_controller.text);
                    _controller.text = password;
                  });
                },
                text: AppStrings.generatePassword,
              ),
            ),)
          ],
        ),
      ),
    );
  }
  String generatePassword({ bool? normal = true,
  bool? strong = false,
  bool? veryStrong = false}){

    const length = 12;
    const lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
    const upperCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const numbers = '0123456789';
    const special = '@#=£p+!\$%&(){}';

    String chars = '';
    if(normal!) chars += '$lowerCaseLetters$upperCaseLetters';
    if(strong!) chars += numbers;
    if(veryStrong!) chars +='$numbers$special';
    
    return List.generate(length, (index) {
        final randomIndex = Random.secure().nextInt(chars.length);
    return chars[randomIndex];
    }).join('');

  }
}
