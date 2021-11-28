import 'package:flutter/material.dart';
import 'package:passwordmanager/bottomBarScreens/add_account_screen.dart';
import 'package:passwordmanager/bottomBarScreens/generate_password_screen.dart';
import 'package:passwordmanager/bottomBarScreens/home_screen.dart';
import 'package:passwordmanager/bottomBarScreens/settings_screen.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/text_const.dart';
import 'package:sizer/sizer.dart';

import 'custom_text.dart';

class DrawerTile extends StatefulWidget {
  final Icon? icon;
  final String? title;
  bool? isSelected;
  Function(int?)? returnIndex;
  int? index;

  DrawerTile(
      {Key? key,
      this.icon,
      this.title,
      this.isSelected,
      this.index,
      this.returnIndex})
      : super(key: key);

  @override
  _DrawerTileState createState() => _DrawerTileState();
}

class _DrawerTileState extends State<DrawerTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.returnIndex!(widget.index);
        });
        widget.index == 0
            ? AppNavigation.navigateTo(context, const HomeScreen())
            : widget.index == 1
                ? AppNavigation.navigateTo(
                    context, const GeneratePasswordScreen())
                : widget.index == 2
                    ? AppNavigation.navigateTo(
                        context, const AddAccountScreen())
                    : AppNavigation.navigateTo(context, const SettingsScreen());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            color: AppColors.scaffoldColor,
            borderRadius: BorderRadius.circular(10),
            border: widget.isSelected == false
                ? Border.all(color: AppColors.borderColor3, width: 1)
                : null,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor.withOpacity(0.05),
                blurRadius: 54,
                offset: const Offset(10, 24),
              )
            ]),
        child: ListTile(
          leading: SizedBox(
            height: 100.h,
              child: widget.icon),
          title: CustomText(
            title: widget.title,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
