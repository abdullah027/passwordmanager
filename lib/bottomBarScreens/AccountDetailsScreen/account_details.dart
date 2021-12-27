import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passwordmanager/bottomBarScreens/password_detail_screen.dart';
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
import '../../services/providers/account_provider.dart';

class AccountDetailsScreen extends StatefulWidget {

  @override
  _AccountDetailsScreenState createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  String? selectedCategory, iconString;
  TextEditingController domainController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<Icon> icons = const [
    Icon(Icons.wifi_tethering, size: 18, color: Colors.white),
    Icon(Icons.language, size: 18, color: Colors.white),
    Icon(Icons.school_outlined, size: 18, color: Colors.white),
    Icon(Icons.account_balance_wallet_outlined, size: 18, color: Colors.white),
  ];
  List<Icon> catIcons = const [
    Icon(Icons.wifi_tethering, size: 16, color: Colors.white),
    Icon(Icons.language, size: 16, color: Colors.white),
    Icon(Icons.school_outlined, size: 16, color: Colors.white),
    Icon(Icons.account_balance_wallet_outlined, size: 16, color: Colors.white),
  ];
  List categories = ["Social Media", "Google", "Study", "Wallet"];
  int? selIndex;
  bool isSelected = true;

  @override
  void didChangeDependencies() {
    initValues();
    super.didChangeDependencies();
  }

  void initValues() {
    var accountProvider = Provider.of<AccountProvider>(context, listen: false);
    fullNameController.text = accountProvider.account!.fullName!;
    emailController.text = accountProvider.account!.email!;
    domainController.text = accountProvider.account!.domain!;
    passwordController.text = decrypt(accountProvider.account!.password!)!;
  }

  @override
  void initState() {
    print(FirebaseAuth.instance.currentUser?.uid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var accountProvider = Provider.of<AccountProvider>(context, listen: true);
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      backgroundColor: _themeChanger.getTheme() == ThemeMode.dark
          ? Colors.black
          : AppColors.scaffoldColor,
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          title: AppStrings.accountDetails,
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
                    //   height: 30,
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
                      hintText:
                          accountProvider.account?.fullName ?? "Norton Film",
                      fillColor: _themeChanger.getTheme() == ThemeMode.dark
                          ? Colors.black
                          : AppColors.scaffoldColor,
                      enabled: false,
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
                      hintText: accountProvider.account?.domain ??
                          "www.sitegoeshere.co.id",
                      fillColor: _themeChanger.getTheme() == ThemeMode.dark
                          ? Colors.black
                          : AppColors.scaffoldColor,
                      enabled: false,
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
                      enabled: false,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        size: 20,
                        color: _themeChanger.getTheme() == ThemeMode.dark
                            ? AppColors.scaffoldColor
                            : Colors.black,
                      ),
                      hintText: accountProvider.account?.email ??
                          "annisahy@gmail.com",
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
                      //enabled: false,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        size: 20,
                        color: _themeChanger.getTheme() == ThemeMode.dark
                            ? AppColors.scaffoldColor
                            : Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          isSelected = !isSelected;
                        });
                      },
                      obscureText: isSelected,
                      suffixIcon: isSelected == false
                          ? const Icon(CupertinoIcons.eye)
                          : const Icon(CupertinoIcons.eye_slash),
                      hintText: isSelected == true
                          ? "•••••••••••••"
                          : accountProvider.account?.password ??
                              "•••••••••••••",
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
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                MyCategoryCard(
                                  text: accountProvider.account?.category == 0?categories[0]:accountProvider.account?.category == 1?categories[1]:accountProvider.account?.category == 2?categories[2]:accountProvider.account?.category == 3?categories[3]:
                                      'Not specified',
                                  //icon: accountProvider.account?.category != categories[index]?Icon(Icons.non):,
                                  index: index,
                                  icon: Icon(
                                    catIcons[accountProvider.account!.category!]
                                        .icon,
                                    color: catIcons[
                                            accountProvider.account!.category!]
                                        .color,
                                    size: 18,
                                  ),
                                  isSelected: index == selIndex ? true : false,
                                  returnIndex: (catchIndex) {
                                    setState(() {
                                      selIndex = catchIndex;
                                      selectedCategory = categories[index];
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
                    onPressed: () {
                      AppNavigation.navigateTo(context, const PasswordDetailScreen());
                    },
                    width: 100.w,
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
