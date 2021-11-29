import 'package:flutter/material.dart';
import 'package:passwordmanager/bottomBarScreens/generate_password_screen.dart';
import 'package:passwordmanager/bottomBarScreens/home_screen.dart';
import 'package:passwordmanager/bottomBarScreens/password_detail_screen.dart';
import 'package:passwordmanager/bottomBarScreens/settings_screen.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/them_changer.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BottomNavBar extends StatefulWidget {
  final int? index;
  const BottomNavBar({Key? key, this.index}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Container(
      height: 6.h,
      decoration: BoxDecoration(
          color: _themeChanger.getTheme() == ThemeMode.dark?AppColors.scaffoldColor2:AppColors.scaffoldColor,
          border: Border.all(width:_themeChanger.getTheme() == ThemeMode.dark?0:1, color: _themeChanger.getTheme() == ThemeMode.dark?Colors.black:AppColors.borderColor),
          boxShadow: [
            BoxShadow(blurRadius:_themeChanger.getTheme() == ThemeMode.dark?54: 1, color:_themeChanger.getTheme() == ThemeMode.dark? Colors.white.withOpacity(0.15):AppColors.borderColor)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  AppNavigation.navigateReplacement(
                      context, const HomeScreen());
                });
              },
              icon: Icon(
                Icons.home_outlined,
                color: widget.index == 0
                    ? AppColors.blueText
                    : _themeChanger.getTheme() == ThemeMode.dark?AppColors.greyText:AppColors.greyText.withOpacity(0.3),
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  AppNavigation.navigateReplacement(
                      context, const PasswordDetailScreen());
                });
              },
              icon: Icon(
                Icons.verified_user_outlined,
                size: 20,
                color: widget.index == 1
                    ? AppColors.blueText
                    : _themeChanger.getTheme() == ThemeMode.dark?AppColors.greyText:AppColors.greyText.withOpacity(0.3),
              )),
          const SizedBox(
            height: 20,
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  AppNavigation.navigateReplacement(
                      context, const GeneratePasswordScreen());
                });
              },
              icon: Icon(
                Icons.lock_outline,
                size: 20,
                color: widget.index == 2
                    ? AppColors.blueText
                    : _themeChanger.getTheme() == ThemeMode.dark?AppColors.greyText:AppColors.greyText.withOpacity(0.3),
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  AppNavigation.navigateReplacement(context, const SettingsScreen());

                });
              },
              icon: Icon(
                Icons.settings_outlined,
                size: 20,
                color: widget.index == 3
                    ? AppColors.blueText
                    : _themeChanger.getTheme() == ThemeMode.dark?AppColors.greyText:AppColors.greyText.withOpacity(0.3),
              )),
        ],
      ),
    );
  }
}
