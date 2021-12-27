import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwordmanager/Models/account_model.dart';
import 'package:passwordmanager/services/firestore_database.dart';
import 'package:passwordmanager/services/providers/user_provider.dart';
import 'package:passwordmanager/sharedWidgets/custom_blue_button.dart';
import 'package:passwordmanager/sharedWidgets/custom_text.dart';
import 'package:passwordmanager/sharedWidgets/custom_text_field.dart';
import 'package:passwordmanager/sharedWidgets/my_category_card.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/encrypt_decrypt.dart';
import 'package:passwordmanager/utilis/text_const.dart';
import 'package:passwordmanager/utilis/them_changer.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/providers/account_provider.dart';

class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen({Key? key}) : super(key: key);

  @override
  _AddAccountScreenState createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  TextEditingController domainController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int? selectedCategory;
  String? iconString;

  List<Icon> icons = const [
    Icon(Icons.wifi_tethering, size: 18, color: Colors.white),
    Icon(Icons.language, size: 18, color: Colors.white),
    Icon(Icons.school_outlined, size: 18, color: Colors.white),
    Icon(Icons.account_balance_wallet_outlined, size: 18, color: Colors.white),
  ];
  List categories = ["Social Media", "Google", "Study", "Wallet"];
  int? selIndex;

  @override
  void initState() {
    print(FirebaseAuth.instance.currentUser?.uid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: true);
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      backgroundColor: _themeChanger.getTheme() == ThemeMode.dark
          ? Colors.black
          : AppColors.scaffoldColor,
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          title: AppStrings.addAccountScreen,
          fontWeight: FontWeight.w900,
          fontSize: 16,
          textColor: _themeChanger.getTheme() == ThemeMode.dark
              ? AppColors.scaffoldColor
              : Colors.black,
        ),
        leading: IconButton(
          onPressed: () {
            AppNavigation.navigatorPop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: _themeChanger.getTheme() == ThemeMode.dark
                ? AppColors.scaffoldColor
                : AppColors.blueButtonColor,
            size: 20,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Center(
                    //   child: Container(
                    //     height: 60,
                    //     width: 60,
                    //     decoration: DottedDecoration(
                    //       dash: const [8],
                    //       shape: Shape.circle,
                    //       color: _themeChanger.getTheme() == ThemeMode.dark
                    //           ? AppColors.scaffoldColor
                    //           : AppColors.blueButtonColor,
                    //     ),
                    //     child: IconButton(
                    //       onPressed: () {},
                    //       icon: FaIcon(
                    //         FontAwesomeIcons.image,
                    //         color: _themeChanger.getTheme() == ThemeMode.dark
                    //             ? AppColors.scaffoldColor
                    //             : AppColors.blueButtonColor,
                    //         size: 20,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // Center(
                    //   child: CustomText(
                    //     title: AppStrings.changeIcon,
                    //     fontWeight: FontWeight.w900,
                    //     fontSize: 14,
                    //     textColor: _themeChanger.getTheme() == ThemeMode.dark
                    //         ? AppColors.scaffoldColor
                    //         : AppColors.blueButtonColor,
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    CustomText(
                      title: AppStrings.fullName,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      textColor: _themeChanger.getTheme() == ThemeMode.dark
                          ? AppColors.scaffoldColor
                          : Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: fullNameController,
                      hintText: "Norton Film",
                      fillColor: _themeChanger.getTheme() == ThemeMode.dark
                          ? Colors.black
                          : AppColors.scaffoldColor,
                      prefixIcon: Icon(
                        CupertinoIcons.person,
                        size: 20,
                        color: _themeChanger.getTheme() == ThemeMode.dark
                            ? AppColors.scaffoldColor
                            : Colors.black,
                      ),
                      enableBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: AppColors.borderColor3, width: 1)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      title: AppStrings.website,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      textColor: _themeChanger.getTheme() == ThemeMode.dark
                          ? AppColors.scaffoldColor
                          : Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: domainController,
                      hintText: "www.sitegoeshere.co.id",
                      fillColor: _themeChanger.getTheme() == ThemeMode.dark
                          ? Colors.black
                          : AppColors.scaffoldColor,
                      prefixIcon: Icon(
                        CupertinoIcons.globe,
                        size: 20,
                        color: _themeChanger.getTheme() == ThemeMode.dark
                            ? AppColors.scaffoldColor
                            : Colors.black,
                      ),
                      enableBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: AppColors.borderColor3, width: 1)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      title: AppStrings.emailAddress,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      textColor: _themeChanger.getTheme() == ThemeMode.dark
                          ? AppColors.scaffoldColor
                          : Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: emailController,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        size: 20,
                        color: _themeChanger.getTheme() == ThemeMode.dark
                            ? AppColors.scaffoldColor
                            : Colors.black,
                      ),
                      hintText: "annisahy@gmail.com",
                      fillColor: _themeChanger.getTheme() == ThemeMode.dark
                          ? Colors.black
                          : AppColors.scaffoldColor,
                      enableBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: AppColors.borderColor3, width: 1)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      title: AppStrings.password,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      textColor: _themeChanger.getTheme() == ThemeMode.dark
                          ? AppColors.scaffoldColor
                          : Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: passwordController,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        size: 20,
                        color: _themeChanger.getTheme() == ThemeMode.dark
                            ? AppColors.scaffoldColor
                            : Colors.black,
                      ),
                      obscureText: true,
                      hintText: "•••••••••••••",
                      fillColor: _themeChanger.getTheme() == ThemeMode.dark
                          ? Colors.black
                          : AppColors.scaffoldColor,
                      enableBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: AppColors.borderColor3, width: 1)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      title: AppStrings.myCategoryAccount,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                    SizedBox(
                      height: 20.h,
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: icons.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                MyCategoryCard(
                                  text: categories[index],
                                  icon: icons[index],
                                  index: index,
                                  isSelected: index == selIndex ? true : false,
                                  returnIndex: (catchIndex) {
                                    setState(() {
                                      selIndex = catchIndex;
                                      selectedCategory = index;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CustomBlueButton(
                    text: AppStrings.checkPasswordDetails,
                    color: AppColors.greenColor,
                    borderRadius: BorderRadius.circular(10),
                    onPressed: () {},
                    width: 100.w,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomBlueButton(
                    text: AppStrings.saveAccount,
                    borderRadius: BorderRadius.circular(10),
                    width: 100.w,
                    onPressed: () {
                      if (domainController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          passwordController.text.isEmpty ||
                          selectedCategory == null) {
                        Fluttertoast.showToast(msg: AppStrings.fieldMissing);
                      } else {
                        if (!FirebaseAuth.instance.currentUser!.emailVerified) {
                          Fluttertoast.showToast(msg: AppStrings.unAuthorized);
                        } else {
                          final message = utf8.encode(passwordController.text);
                          Provider.of<AccountProvider>(context, listen: false)
                              .addAccounts(
                                  domain: domainController.text,
                                  category: selectedCategory,
                                  email: emailController.text,
                                  password: encrypt(passwordController.text),
                                  fullName: fullNameController.text.isEmpty
                                      ? userProvider.user?.fullName
                                      : fullNameController.text,
                                  uid: FirebaseAuth.instance.currentUser?.uid);
                          AppNavigation.navigatorPop(context);
                        }
                      }

                      //AppNavigation.navigatorPop(context);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
