import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passwordmanager/sharedWidgets/custom_blue_button.dart';
import 'package:passwordmanager/sharedWidgets/custom_text.dart';
import 'package:passwordmanager/sharedWidgets/custom_text_field.dart';
import 'package:passwordmanager/sharedWidgets/my_category_card.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/text_const.dart';
import 'package:sizer/sizer.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen({Key? key}) : super(key: key);

  @override
  _AddAccountScreenState createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  List<Icon> icons = const [
    Icon(
      Icons.wifi_tethering,
      size: 18,
      color: Colors.white,
    ),
    Icon(CupertinoIcons.globe, size: 18, color: Colors.white),
    Icon(Icons.school_outlined, size: 18, color: Colors.white),
    Icon(Icons.account_balance_wallet_outlined, size: 18, color: Colors.white),
  ];
  List categories = ["Social Media", "Google", "Study", "Wallet"];
  int? selIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          title: AppStrings.addAccountScreen,
          fontWeight: FontWeight.w900,
          fontSize: 16,
          textColor: Colors.black,
        ),
        leading: IconButton(
          onPressed: () {
            AppNavigation.navigatorPop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.blueButtonColor,
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
                    Center(
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: DottedDecoration(
                          dash: const [8],
                          shape: Shape.circle,
                          color: AppColors.blueButtonColor,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.image,
                            color: AppColors.blueButtonColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: CustomText(
                        title: AppStrings.changeIcon,
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        textColor: AppColors.blueButtonColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      title: AppStrings.website,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      textColor: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: "www.sitegoeshere.co.id",
                      fillColor: AppColors.scaffoldColor,
                      prefixIcon: const Icon(
                        CupertinoIcons.globe,
                        size: 20,
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
                      textColor: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        size: 20,
                      ),
                      hintText: "annisahy@gmail.com",
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
                      title: AppStrings.password,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      textColor: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        size: 20,
                      ),
                      hintText: "•••••••••••••",
                      fillColor: AppColors.scaffoldColor,
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
                                  isSelected: index == selIndex?true:false,
                                  returnIndex: (catchIndex){
                                    setState(() {
                                      selIndex = catchIndex;
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
                    onPressed: () {},
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
