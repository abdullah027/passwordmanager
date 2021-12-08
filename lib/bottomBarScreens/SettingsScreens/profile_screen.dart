import 'dart:io';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '/services/firebase_auth.dart';
import '/services/firestore_database.dart';
import '/services/providers/user_provider.dart';
import '/sharedWidgets/custom_blue_button.dart';
import '/sharedWidgets/custom_clipper.dart';
import '/sharedWidgets/custom_text.dart';
import '/sharedWidgets/custom_text_field.dart';
import '/utilis/asset_paths.dart';
import '/utilis/color_const.dart';
import '/utilis/text_const.dart';
import '/utilis/them_changer.dart';
import '../../utilis/app_navigation.dart';
import '../home_screen.dart';
import '../../utilis/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  File? _chosenFile;

  //call initialize valueson page load
  @override
  void didChangeDependencies() {
    initValues();
    super.didChangeDependencies();
  }

  //initialize all text fields with values
  void initValues() {
    final userData = Provider.of<UserProvider>(context);
    fullNameController.text = userData.user!.fullName!;
    emailController.text = userData.user!.email!;
    phoneController.text = userData.user!.phone!;
  }

  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: true);
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      backgroundColor: _themeChanger.getTheme() == ThemeMode.dark
          ? AppColors.scaffoldColor2
          : AppColors.scaffoldColor,
      body: Stack(
        children: [
          SizedBox(
            height: 100.h,
            width: 100.w,
            child: Row(
              children: [
                Container(
                  height: 100.h,
                  width: 50.w,
                  color: _themeChanger.getTheme() == ThemeMode.dark
                      ? AppColors.scaffoldColor2
                      : AppColors.scaffoldColor,
                ),
                Container(
                  height: 100.h,
                  width: 50.w,
                  color: AppColors.blueButtonColor,
                ),
              ],
            ),
          ),
          Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 35.h),
                child: Container(
                  width: 100.w,
                  decoration: const BoxDecoration(
                    color: AppColors.blueButtonColor,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(60)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                              onPressed: () {
                                AppNavigation.navigateReplacement(
                                    context, const HomeScreen());
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: AppColors.scaffoldColor,
                              ))),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                maxRadius: 45,
                                backgroundColor: AppColors.scaffoldColor,
                                child: userProvider.user!.image != null
                                    ? Image.network(userProvider.user!.image!)
                                    : Image.asset(
                                        AssetPaths.profile,
                                        height: 80,
                                      ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  decoration: const BoxDecoration(
                                    color: AppColors.scaffoldColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    constraints: const BoxConstraints(
                                      maxWidth: 16,
                                      maxHeight: 16,
                                      minHeight: 14,
                                      minWidth: 14,
                                    ),
                                    icon: const FaIcon(
                                      FontAwesomeIcons.solidEdit,
                                      color: AppColors.blueButtonColor,
                                      size: 16,
                                    ),
                                    onPressed: () async {
                                      final chosenImage =
                                          await ImagePicker().pickImage(
                                        source: ImageSource.gallery,
                                      );
                                      setState(() {
                                        _chosenFile = File(chosenImage!.path);
                                      });
                                      Provider.of<UserProvider>(context,
                                              listen: false)
                                          .setProfilePic(
                                              _chosenFile!,
                                              FirebaseAuth
                                                  .instance.currentUser!.uid);

                                      print('Pressed');
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomText(
                            title: AppStrings.changeProfilePicture,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            textColor: AppColors.scaffoldColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: _themeChanger.getTheme() == ThemeMode.dark
                        ? AppColors.scaffoldColor2
                        : AppColors.scaffoldColor,
                    borderRadius:
                        const BorderRadius.only(topRight: Radius.circular(60)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: AppStrings.fullName,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            textColor: AppColors.blueButtonColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: fullNameController,
                            hintText:
                                userProvider.user?.fullName ?? "Daniel Braun",
                            fillColor:
                                _themeChanger.getTheme() == ThemeMode.dark
                                    ? AppColors.scaffoldColor2
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
                            title: AppStrings.emailAddress,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            textColor: AppColors.blueButtonColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: emailController,
                            hintText: userProvider.user?.email ??
                                "danielbraun691@gmail.com",
                            fillColor:
                                _themeChanger.getTheme() == ThemeMode.dark
                                    ? AppColors.scaffoldColor2
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
                            title: AppStrings.phoneNumber,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            textColor: AppColors.blueButtonColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: phoneController,
                            hintText:
                                userProvider.user?.phone ?? "+1 343 454 564",
                            fillColor:
                                _themeChanger.getTheme() == ThemeMode.dark
                                    ? AppColors.scaffoldColor2
                                    : AppColors.scaffoldColor,
                            enableBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: AppColors.borderColor3, width: 1)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomBlueButton(
                            onPressed: () {
                              AuthenticationService(FirebaseAuth.instance)
                                  .updateUser(
                                fullNameController.text.isEmpty
                                    ? userProvider.user?.fullName
                                    : fullNameController.text,
                                emailController.text.isEmpty
                                    ? userProvider.user?.email
                                    : emailController.text,
                                phoneController.text.isEmpty
                                    ? userProvider.user?.phone
                                    : phoneController.text,
                                context,
                              );
                            },
                            width: 100.w,
                            borderRadius: BorderRadius.circular(10),
                            text: AppStrings.saveChanges,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomText(
                            title: AppStrings.notifications,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            textColor:
                                _themeChanger.getTheme() == ThemeMode.dark
                                    ? AppColors.scaffoldColor
                                    : Colors.black,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                title: AppStrings.app,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                textColor:
                                    _themeChanger.getTheme() == ThemeMode.dark
                                        ? AppColors.scaffoldColor
                                        : AppColors.appColor,
                              ),
                              Transform.scale(
                                scale: 0.5,
                                child: CupertinoSwitch(
                                  activeColor: AppColors.blueButtonColor,
                                  value: _switchValue,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _switchValue = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
