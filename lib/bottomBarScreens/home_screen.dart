import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passwordmanager/Models/account_model.dart';
import 'package:passwordmanager/authScreens/verification_screen.dart';
import 'package:passwordmanager/bottomBarScreens/SettingsScreens/profile_screen.dart';
import 'package:passwordmanager/bottomBarScreens/add_account_screen.dart';
import 'package:passwordmanager/services/firebase_auth.dart';
import 'package:passwordmanager/services/firestore_database.dart';
import 'package:passwordmanager/services/providers/account_provider.dart';
// import 'package:passwordmanager/services/providers/account_provider.dart';
import 'package:passwordmanager/services/providers/user_provider.dart';
import 'package:passwordmanager/sharedWidgets/bottom_navigation_bar.dart';
import 'package:passwordmanager/sharedWidgets/custom_text.dart';
import 'package:passwordmanager/sharedWidgets/drawer_tile.dart';
import 'package:passwordmanager/sharedWidgets/my_category_card.dart';
import 'package:passwordmanager/utilis/app_navigation.dart';
import 'package:passwordmanager/utilis/asset_paths.dart';
import 'package:passwordmanager/utilis/color_const.dart';
import 'package:passwordmanager/utilis/text_const.dart';
import 'package:passwordmanager/utilis/them_changer.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final panelController = PanelController();
  final panel2Controller = PanelController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final user = FirebaseAuth.instance.currentUser;
  final CollectionReference _collectionRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('accounts');

  int selIndex = 0;
  bool? isSelected = false;

  List titles = [
    AppStrings.home,
    AppStrings.generatePassword,
    AppStrings.rateApp,
    AppStrings.settings,
  ];
  List<IconData> drawerIcons = const [
    Icons.home,
    Icons.lock,
    Icons.star_rate_rounded,
    Icons.settings
  ];

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

  // Future<List<Object?>> getAccounts() async {
  //   // Get docs from collection reference
  //   QuerySnapshot querySnapshot = await _collectionRef.get();
  //   final data = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   setState(() {
  //     _accounts = data;
  //   });
  //
  //   return data;
  // }

  @override
  void initState() {
    AuthenticationService(FirebaseAuth.instance).getAccounts(context);
    //getAccounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: true);
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    var accountProvider = Provider.of<AccountProvider>(context, listen: true);
    //print(accountProvider.getAccounts);
    return Scaffold(
        backgroundColor: _themeChanger.getTheme() == ThemeMode.dark
            ? AppColors.scaffoldColor2
            : AppColors.blueButtonColor,
        key: _key,
        drawer: SafeArea(child: _drawer()),
        extendBodyBehindAppBar: true,
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
          index: 0,
        ),
        body: Stack(
          children: [
            SlidingUpPanel(
                color: _themeChanger.getTheme() == ThemeMode.dark
                    ? Colors.black
                    : AppColors.scaffoldColor,
                controller: panelController,
                minHeight: 35.h,
                maxHeight: 70.h,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                body: SlidingUpPanel(
                  color: _themeChanger.getTheme() == ThemeMode.dark
                      ? Colors.black
                      : AppColors.scaffoldColor,
                  controller: panel2Controller,
                  minHeight: 70.h,
                  maxHeight: 80.h,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  body: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(AssetPaths.ellipse20),
                      alignment: Alignment.topCenter,
                    )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          _customAppBar(),
                          CustomText(
                            title: AppStrings.welcomeBack,
                            textColor: AppColors.scaffoldColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            title: (userProvider.user?.fullName ??
                                    userProvider.user?.email) ??
                                'Annisa Handayani',
                            textColor: AppColors.scaffoldColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              _searchField(),
                              const SizedBox(
                                width: 10,
                              ),
                              _filterButton(),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  panelBuilder: (controller) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: AppStrings.myCategoryAccount,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          textColor: _themeChanger.getTheme() == ThemeMode.dark
                              ? AppColors.scaffoldColor
                              : Colors.black,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                panel2Controller.isPanelOpen
                                    ? panel2Controller.close()
                                    : panel2Controller.open();
                              });
                            },
                            child: Center(
                                child: Container(
                              height: 5,
                              width: 50,
                              decoration: BoxDecoration(
                                  color:
                                      _themeChanger.getTheme() == ThemeMode.dark
                                          ? AppColors.scaffoldColor
                                          : AppColors.handleColor,
                                  borderRadius: BorderRadius.circular(20)),
                            ))),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20.h,
                          child: ListView.builder(
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
                panelBuilder: (controller) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: "Latest Account",
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            textColor:
                                _themeChanger.getTheme() == ThemeMode.dark
                                    ? AppColors.scaffoldColor
                                    : Colors.black,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  panelController.isPanelOpen
                                      ? panelController.close()
                                      : panelController.open();
                                });
                              },
                              child: Center(
                                  child: Container(
                                height: 5,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: _themeChanger.getTheme() ==
                                            ThemeMode.dark
                                        ? AppColors.scaffoldColor
                                        : AppColors.handleColor,
                                    borderRadius: BorderRadius.circular(20)),
                              ))),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                physics: const BouncingScrollPhysics(),
                                itemCount: accountProvider.accounts.isEmpty
                                    ? 3
                                    : accountProvider.accounts.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      _listTile(
                                          accountProvider.accounts, index),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ),
                    )),
            user == null
                ? Container()
                : user!.emailVerified
                    ? Container()
                    : Positioned(
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            AppNavigation.navigateTo(
                                context, const VerificationScreen());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            color: AppColors.blueButtonColor,
                            height: 10.h,
                            width: 100.w,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  title: AppStrings.verifyText,
                                  textColor: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                CustomText(
                                  title:
                                      "Your email is not verified, tap here and verify your email.",
                                  textColor: Colors.white,
                                  fontSize: 12,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
          ],
        ));
  }

  Widget _customAppBar() {
    var userProvider = Provider.of<UserProvider>(context, listen: true);
    return Container(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                _key.currentState!.openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: AppColors.scaffoldColor,
              )),
          GestureDetector(
            onTap: () {
              AppNavigation.navigateTo(context, const ProfileScreen());
            },
            child: userProvider.user?.image != null
                ? CircleAvatar(
                    maxRadius: 30,
                    backgroundImage: NetworkImage(userProvider.user!.image!),
                    backgroundColor: AppColors.scaffoldColor,
                  )
                : const CircleAvatar(
                    maxRadius: 30,
                    backgroundImage: AssetImage(
                      AssetPaths.profile,
                    ),
                    backgroundColor: AppColors.scaffoldColor,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _drawer() {
    var userProvider = Provider.of<UserProvider>(context, listen: true);
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Drawer(
      child: Container(
        width: 40.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: _themeChanger.getTheme() == ThemeMode.dark
              ? Colors.black
              : AppColors.scaffoldColor,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppColors.borderColor2, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowColor.withOpacity(0.05),
                              blurRadius: 54,
                              offset: const Offset(10, 24),
                            ),
                          ]),
                      child: ListTile(
                        leading: userProvider.user?.image != null
                            ? CircleAvatar(
                                maxRadius: 24,
                                backgroundImage:
                                    NetworkImage(userProvider.user!.image!),
                                backgroundColor: AppColors.scaffoldColor,
                              )
                            : const CircleAvatar(
                                maxRadius: 24,
                                backgroundImage: AssetImage(
                                  AssetPaths.profile,
                                ),
                                backgroundColor: AppColors.scaffoldColor,
                              ),
                        title: CustomText(
                          title:
                              userProvider.user?.fullName ?? "Annisa Handayani",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          textColor: _themeChanger.getTheme() == ThemeMode.dark
                              ? AppColors.scaffoldColor
                              : Colors.black,
                        ),
                        subtitle: CustomText(
                          title:
                              userProvider.user?.email ?? 'annisahy@gmail.com',
                          fontSize: 12,
                          textColor: _themeChanger.getTheme() == ThemeMode.dark
                              ? AppColors.scaffoldColor
                              : Colors.black,
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: _themeChanger.getTheme() == ThemeMode.dark
                                ? AppColors.scaffoldColor
                                : AppColors.handleColor,
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: titles.length,
                        itemBuilder: (context, index) {
                          return DrawerTile(
                            icon: drawerIcons[index],
                            title: titles[index],
                            index: index,
                            isSelected: selIndex == index ? true : false,
                            returnIndex: (catchIndex) {
                              setState(() {
                                selIndex = catchIndex!;
                              });
                            },
                          );
                        }),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: GestureDetector(
                onTap: () {
                  AuthenticationService(FirebaseAuth.instance)
                      .signOut(context)
                      .then((value) {
                    _themeChanger.setTheme(ThemeMode.light);
                  });
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      color: _themeChanger.getTheme() == ThemeMode.dark
                          ? Colors.black
                          : AppColors.scaffoldColor,
                      borderRadius: BorderRadius.circular(10),
                      border: _themeChanger.getTheme() == ThemeMode.dark
                          ? isSelected == false
                              ? Border.all(color: Colors.transparent, width: 0)
                              : Border.all(
                                  color: AppColors.borderColor3, width: 1)
                          : isSelected == false
                              ? Border.all(
                                  color: AppColors.borderColor3, width: 1)
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
                        child: const Icon(
                          Icons.logout,
                          color: AppColors.blueButtonColor,
                          size: 20,
                        )),
                    title: CustomText(
                      title: AppStrings.logout,
                      textColor: AppColors.blueButtonColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _searchField() {
    return Expanded(
      child: Container(
        height: 50,
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.justify,
          controller: _searchController,
          decoration: const InputDecoration(
              hintText: AppStrings.search,
              hintStyle: TextStyle(fontSize: 14),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                size: 20,
              )),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.scaffoldColor,
            boxShadow: const [
              BoxShadow(
                  color: AppColors.shadowColor, blurRadius: 10, spreadRadius: 1)
            ]),
      ),
    );
  }

  Widget _filterButton() {
    return Container(
      height: 50,
      child: Center(
        child: IconButton(
          onPressed: () {
            // showDialog(
            //     context: context,
            //     builder: (BuildContext context) {
            //       return StatefulBuilder(builder: (context, setState) {
            //         return AlertDialog(
            //           content: Container(
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(20),
            //             ),
            //             child: Column(
            //               mainAxisSize: MainAxisSize.min,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 CustomText(
            //                   title: "Price",
            //                   fontSize: 16,
            //                   fontWeight: FontWeight.w600,
            //                 ),
            //                 // SfSlider(
            //                 //   stepSize: 500,
            //                 //   activeColor: AppColors.PRIMARY_COLOR,
            //                 //   labelPlacement: LabelPlacement.onTicks,
            //                 //
            //                 //   showTicks: true,
            //                 //   showLabels: true,
            //                 //   enableTooltip: true,
            //                 //   onChanged: (dynamic value) {
            //                 //     setState(() {
            //                 //       _value = value;
            //                 //     });
            //                 //   },
            //                 //   value: _value,
            //                 //   min: 0,
            //                 //   max: 100000,
            //                 //
            //                 // ),
            //               ],
            //             ),
            //           ),
            //         );
            //       });
            //     });
          },
          icon: const Icon(
            CupertinoIcons.slider_horizontal_3,
            color: AppColors.scaffoldColor,
            size: 20,
          ),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.orangeColor,
          boxShadow: const [
            BoxShadow(
                color: AppColors.shadowColor, blurRadius: 10, spreadRadius: 1)
          ]),
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
      child: Column(
        children: [
          ListTile(
            leading: Image.asset(
              AssetPaths.profile,
              height: 40,
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
              title: data.isEmpty ? 'annisahy@gmail.com' : data[index].email,
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
                            Provider.of<AccountProvider>(context, listen: false)
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
    );
  }
}
