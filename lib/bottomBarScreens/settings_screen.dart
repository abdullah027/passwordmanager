import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passwordmanager/bottomBarScreens/home_screen.dart';
import 'package:passwordmanager/bottomBarScreens/SettingsScreens/profile_screen.dart';
import 'package:passwordmanager/services/providers/user_provider.dart';
import 'package:passwordmanager/sharedWidgets/bottom_navigation_bar.dart';
import 'package:passwordmanager/sharedWidgets/custom_blue_button.dart';
import 'package:passwordmanager/sharedWidgets/custom_text.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/asset_paths.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/text_const.dart';
import 'package:passwordmanager/utilis/them_changer.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'add_account_screen.dart';

enum _ThemeType { light, dark }

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  _ThemeType? _themeType = _ThemeType.light;
  bool? isSelected;
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context,listen: false);
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      backgroundColor: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor2:AppColors.scaffoldColor,
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          title: AppStrings.settings,
          fontWeight: FontWeight.w900,
          fontSize: 16,
          textColor: AppColors.blueButtonColor,
        ),
        leading: IconButton(
          onPressed: () {
            AppNavigation.navigateTo(context, const HomeScreen());
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.appBarIconColor,
            size: 20,
          ),
        ),
      ),
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
        index: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    color: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor2:AppColors.scaffoldColor,
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
                    title: (userProvider.user?.fullName ?? userProvider.user?.email)??"Daniel Braun",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.blueButtonColor,
                  ),
                  subtitle: CustomText(
                    title: userProvider.user?.email??"danielbraun691@gmail.com",
                    fontSize: 12,
                    textColor: AppColors.greyText,
                  ),
                  trailing: CustomBlueButton(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    onPressed: (){
                      AppNavigation.navigateTo(context, const ProfileScreen());
                    },
                    text: AppStrings.edit,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
               padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor2:AppColors.scaffoldColor,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    CustomText(
                      title: AppStrings.profile,
                      fontWeight: FontWeight.w900,
                      textAlign: TextAlign.left,
                      textColor: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.black,
                    ),
                    const SizedBox(height: 10,),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.person_outline,color: AppColors.blueButtonColor,size: 20,),
                      title: CustomText(title: AppStrings.inviteFriends,fontSize: 12,fontWeight: FontWeight.w600,textColor: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.black,),
                      trailing: Icon(Icons.arrow_forward_ios_rounded,size: 16,color: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.black,),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.notifications_none_outlined,color: AppColors.blueButtonColor,size: 20),
                      title: CustomText(title: AppStrings.notifications,fontSize: 12,fontWeight: FontWeight.w600,textColor: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.black,),
                      trailing: Icon(Icons.arrow_forward_ios_rounded,size: 16,color: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.black,),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.wb_sunny_outlined,color: AppColors.blueButtonColor,size: 20),
                      title: CustomText(title: AppStrings.theme,fontSize: 12,fontWeight: FontWeight.w600,textColor: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:Colors.black,),
                      trailing: Transform.scale(
                        scale: 0.5,
                        child: CupertinoSwitch(
                          activeColor: AppColors.blueButtonColor,
                          thumbColor:  _themeChanger.getTheme() == ThemeMode.dark?Colors.black:AppColors.scaffoldColor,
                          value: _switchValue,
                          onChanged: (bool value) {
                            setState(() {
                              _switchValue = value;

                            });
                            _switchValue == true? _themeChanger.setTheme(ThemeMode.dark): _themeChanger.setTheme(ThemeMode.light);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor2:AppColors.scaffoldColor,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    CustomText(
                      title: AppStrings.security,
                      fontWeight: FontWeight.w900,
                      textAlign: TextAlign.left,
                      textColor: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:AppColors.scaffoldColor2,
                    ),
                    const SizedBox(height: 10,),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.lock,color: AppColors.blueButtonColor,size: 20,),
                      title: CustomText(title: AppStrings.password,fontSize: 12,fontWeight: FontWeight.w600,textColor: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:AppColors.scaffoldColor2,),
                      trailing: Icon(Icons.arrow_forward_ios_rounded,size: 16,color: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:AppColors.scaffoldColor2,),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.security,color: AppColors.blueButtonColor,size: 20),
                      title: CustomText(title: AppStrings.twoFactorAuth,fontSize: 12,fontWeight: FontWeight.w600,textColor: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:AppColors.scaffoldColor2,),
                      trailing: Icon(Icons.arrow_forward_ios_rounded,size: 16,color: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor:AppColors.scaffoldColor2,),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _alertDialog(){
    return StatefulBuilder(builder: (context,setState){
      return AlertDialog(
        backgroundColor: AppColors.scaffoldColor,
        actions: [
          Radio(
              value: _ThemeType.light,
              groupValue: _themeType,
              onChanged: (_ThemeType? val) {
                setState(() {
                  _themeType = val;
                });
              }),
          Radio(
              value: _ThemeType.light,
              groupValue: _themeType,
              onChanged: (_ThemeType? val) {
                setState(() {
                  _themeType = val;
                });
              }),
        ],
      );
    });
  }
}
