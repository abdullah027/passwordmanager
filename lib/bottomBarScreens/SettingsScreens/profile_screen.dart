import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passwordmanager/services/firebase_auth.dart';
import 'package:passwordmanager/services/firestore_database.dart';
import 'package:passwordmanager/services/providers/user_provider.dart';
import 'package:passwordmanager/sharedWidgets/custom_blue_button.dart';
import 'package:passwordmanager/sharedWidgets/custom_clipper.dart';
import 'package:passwordmanager/sharedWidgets/custom_text.dart';
import 'package:passwordmanager/sharedWidgets/custom_text_field.dart';
import 'package:passwordmanager/utilis/asset_paths.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/text_const.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utilis/app_navigation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
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
                  color: AppColors.scaffoldColor,
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
                                AppNavigation.navigatorPop(context);
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
                                child: Image.asset(
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
                                  child: const FaIcon(
                                    FontAwesomeIcons.solidEdit,
                                    color: AppColors.blueButtonColor,
                                    size: 12,
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
                  decoration: const BoxDecoration(
                    color: AppColors.scaffoldColor,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(60)),
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
                            fillColor: AppColors.scaffoldColor,
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
                            fillColor: AppColors.scaffoldColor,
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
                            fillColor: AppColors.scaffoldColor,
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
                                      fullNameController.text.isEmpty ?userProvider.user?.fullName:fullNameController.text,
                                      emailController.text.isEmpty?userProvider.user?.email:emailController.text,
                                      phoneController.text.isEmpty?userProvider.user?.phone:phoneController.text,
                                      context);
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
                                textColor: AppColors.appColor,
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
