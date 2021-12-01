import 'package:flutter/material.dart';
import 'package:passwordmanager/sharedWidgets/bottom_navigation_bar.dart';
import 'package:passwordmanager/sharedWidgets/custom_text.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/asset_paths.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/text_const.dart';
import 'package:passwordmanager/utilis/them_changer.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'add_account_screen.dart';

class PasswordDetailScreen extends StatefulWidget {
  const PasswordDetailScreen({Key? key}) : super(key: key);

  @override
  _PasswordDetailScreenState createState() => _PasswordDetailScreenState();
}

class _PasswordDetailScreenState extends State<PasswordDetailScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
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
        index: 1,
      ),
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          title: AppStrings.passwordDetails,
          fontWeight: FontWeight.w900,
          fontSize: 16,
          textColor: _themeChanger.getTheme() == ThemeMode.dark
              ? AppColors.scaffoldColor
              : AppColors.appBarIconColor,
        ),
        leading: IconButton(
          onPressed: () {
            AppNavigation.navigatorPop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: _themeChanger.getTheme() == ThemeMode.dark
                ? AppColors.scaffoldColor
                : AppColors.appBarIconColor,
            size: 20,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: _themeChanger.getTheme() == ThemeMode.dark
                    ? AppColors.scaffoldColor
                    : AppColors.appBarIconColor,
                size: 20,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Center(
                child: SleekCircularSlider(
                  max: 100,
                  min: 0,
                  initialValue: 50,
                  appearance: CircularSliderAppearance(
                    infoProperties: InfoProperties(
                      mainLabelStyle: const TextStyle(
                          color: AppColors.greenColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      bottomLabelText: "Strong",
                      bottomLabelStyle: const TextStyle(
                          color: AppColors.greenColor,
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
                        trackWidth: 2,
                        progressBarWidth: 4),
                    customColors: CustomSliderColors(
                      dynamicGradient: false,
                      progressBarColor: AppColors.greenColor,
                      trackColor:  AppColors.scaffoldColor

                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                          decoration: BoxDecoration(
                              color:  _themeChanger.getTheme() == ThemeMode.dark?Colors.black:AppColors.scaffoldColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.transparent,
                                width: _themeChanger.getTheme() == ThemeMode.dark?1:0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.shadowColor.withOpacity(0.03),
                                  blurRadius: 54,
                                  offset: const Offset(12, 24),
                                ),
                              ]),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  title: "22",
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  textColor: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.black,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  title: "Compromised",
                                  fontWeight: FontWeight.w600,
                                  textColor: AppColors.greenColor,
                                ),
                              ]),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                          decoration: BoxDecoration(
                              color: _themeChanger.getTheme() == ThemeMode.dark?Colors.black:AppColors.scaffoldColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.transparent,
                                width: _themeChanger.getTheme() == ThemeMode.dark?1:0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.shadowColor.withOpacity(0.03),
                                  blurRadius: 54,
                                  offset: const Offset(12, 24),
                                ),
                              ]),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  title: "89",
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  textColor: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.black,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  title: "Weak",
                                  fontWeight: FontWeight.w600,
                                  textColor: AppColors.container1Color,
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                          decoration: BoxDecoration(
                              color: _themeChanger.getTheme() == ThemeMode.dark?Colors.black:AppColors.scaffoldColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.transparent,
                                width: _themeChanger.getTheme() == ThemeMode.dark?1:0,
                              ),
                              boxShadow:  [
                                BoxShadow(
                                  color: AppColors.shadowColor.withOpacity(0.03),
                                  blurRadius: 54,
                                  offset: const Offset(12, 24),
                                ),
                              ]),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  title: "116",
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  textColor: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.black,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  title: "Reused",
                                  fontWeight: FontWeight.w600,
                                  textColor: AppColors.blueButtonColor,
                                ),
                              ]),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                          decoration: BoxDecoration(
                              color: _themeChanger.getTheme() == ThemeMode.dark?Colors.black:AppColors.scaffoldColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.transparent,
                                width: _themeChanger.getTheme() == ThemeMode.dark?1:0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.shadowColor.withOpacity(0.03),
                                  blurRadius: 54,
                                  offset: const Offset(12, 24),
                                ),
                              ]),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  title: "219",
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  textColor: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.black,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  title: "Safe",
                                  fontWeight: FontWeight.w600,
                                  textColor: AppColors.container4Color,
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomText(
                    title: AppStrings.monitoring,
                    fontWeight: FontWeight.w900,
                    textColor: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: _themeChanger.getTheme() == ThemeMode.dark?Colors.black:AppColors.scaffoldColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.transparent,
                          width: _themeChanger.getTheme() == ThemeMode.dark?1:0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowColor.withOpacity(0.03),
                            blurRadius: 54,
                            offset: const Offset(10, 24),
                          ),
                        ]),
                    child: ListTile(
                      leading: Image.asset(
                        AssetPaths.profile,
                        height: 40,
                      ),
                      title: CustomText(
                        title: "annisahy@gmail.com",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textColor: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.black,
                      ),
                      subtitle: CustomText(
                        title: "Pending",
                        fontSize: 12,
                        textColor: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
