import 'package:flutter/material.dart';
import 'package:passwordmanager/bottomBarScreens/generate_password_screen.dart';
import 'package:passwordmanager/bottomBarScreens/home_screen.dart';
import 'package:passwordmanager/bottomBarScreens/password_detail_screen.dart';
import 'package:passwordmanager/bottomBarScreens/settings_screen.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/color_const.dart';
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
    return Container(
      height: 6.h,
      decoration: BoxDecoration(
          color: AppColors.scaffoldColor,
          border: Border.all(width: 1, color: AppColors.borderColor),
          boxShadow: const [
            BoxShadow(blurRadius: 1, color: AppColors.borderColor)
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
                Icons.home,
                color: widget.index == 0
                    ? AppColors.blueText
                    : AppColors.greyText.withOpacity(0.3),
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
                color: widget.index == 1
                    ? AppColors.blueText
                    : AppColors.greyText.withOpacity(0.3),
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
                color: widget.index == 2
                    ? AppColors.blueText
                    : AppColors.greyText.withOpacity(0.3),
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  AppNavigation.navigateReplacement(context, const SettingsScreen());

                });
              },
              icon: Icon(
                Icons.settings,
                color: widget.index == 3
                    ? AppColors.blueText
                    : AppColors.greyText.withOpacity(0.3),
              )),
        ],
      ),
    );
  }
}
