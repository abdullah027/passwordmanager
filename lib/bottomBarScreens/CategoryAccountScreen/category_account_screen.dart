import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:passwordmanager/Models/account_model.dart';
import 'package:passwordmanager/bottomBarScreens/AccountDetailsScreen/account_details.dart';
import 'package:passwordmanager/services/providers/account_provider.dart';
import 'package:passwordmanager/sharedWidgets/custom_text.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/text_const.dart';
import 'package:passwordmanager/utilis/them_changer.dart';
import 'package:provider/provider.dart';

class CategoryAccountDetailsScreen extends StatefulWidget {
  int? category;
  CategoryAccountDetailsScreen({this.category});

  @override
  _CategoryAccountDetailsScreenState createState() =>
      _CategoryAccountDetailsScreenState();
}

class _CategoryAccountDetailsScreenState
    extends State<CategoryAccountDetailsScreen> {
  int? selIndex;

  final user = FirebaseAuth.instance.currentUser;

  List<Icon> catIcons = const [
    Icon(Icons.wifi_tethering, size: 16, color: Colors.white),
    Icon(Icons.language, size: 16, color: Colors.white),
    Icon(Icons.school_outlined, size: 16, color: Colors.white),
    Icon(Icons.account_balance_wallet_outlined, size: 16, color: Colors.white),
  ];
  @override
  Widget build(BuildContext context) {
    var accountProvider = Provider.of<AccountProvider>(context, listen: true);
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    List<Accounts> output = accountProvider.accounts.where((element) {
      if(element.category == widget.category){
        return true;
      }
      else{
        return false;
      }

    }).toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          title: AppStrings.categoryAccountDetails,
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
              child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  physics: const BouncingScrollPhysics(),
                  itemCount: output.isEmpty
                      ? 3
                      : output.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        _listTile(output,index),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTile(List<Accounts> data, int index) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    var accountProvider = Provider.of<AccountProvider>(context, listen: true);
    return Container(
      decoration: BoxDecoration(
          color: _themeChanger.getTheme() == ThemeMode.dark
              ? Colors.black
              : AppColors.scaffoldColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _themeChanger.getTheme() == ThemeMode.dark
                ? AppColors.scaffoldColor
                : Colors.transparent,
            width: _themeChanger.getTheme() == ThemeMode.dark ? 1 : 0,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor.withOpacity(0.05),
              blurRadius: 54,
              offset: const Offset(10, 24),
            )
          ]),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selIndex = index;
          });
          accountProvider.setAccount(data[selIndex!]);
          AppNavigation.navigateTo(context, AccountDetailsScreen());
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              ListTile(
                leading: data.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: data[index].category == 0
                                ? AppColors.container1Color
                                : data[index].category == 1
                                    ? AppColors.container2Color
                                    : data[index].category == 2
                                        ? AppColors.container3Color:
                            data[index].category == 3
                                ? AppColors.container3Color
                                        : AppColors.container4Color,
                            shape: BoxShape.circle),
                        child: Icon(
                          catIcons[data[index].category!].icon,
                          color: catIcons[data[index].category!].color,
                          size: 18,
                        ),
                      )
                    : Image.asset(
                        'assets/images/profile.png',
                        height: 45,
                      ),
                title: CustomText(
                  title: data.isEmpty ? 'Suara Musik' : data[index].fullName,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  textColor: _themeChanger.getTheme() == ThemeMode.dark
                      ? AppColors.scaffoldColor
                      : Colors.black,
                ),
                subtitle: CustomText(
                  title:
                      data.isEmpty ? 'annisahy@gmail.com' : data[index].email,
                  fontSize: 12,
                  textColor: _themeChanger.getTheme() == ThemeMode.dark
                      ? AppColors.scaffoldColor
                      : Colors.black,
                ),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return GestureDetector(
                              onTap: () {
                                Provider.of<AccountProvider>(context,
                                        listen: false)
                                    .deleteAccount(index, user!.uid);
                                Navigator.pop(context);
                              },
                              child: AlertDialog(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                content: CustomText(
                                  title: "Delete",
                                ),
                              ),
                            );
                          });
                        });
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: _themeChanger.getTheme() == ThemeMode.dark
                        ? AppColors.scaffoldColor
                        : AppColors.handleColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 75),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                      title: '•••••••••••••',
                      fontSize: 8,
                      textColor: AppColors.handleColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.remove_red_eye_outlined,
                      size: 14,
                      color: AppColors.handleColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
