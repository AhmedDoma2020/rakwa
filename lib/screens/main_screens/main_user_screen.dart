import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/api/api_controllers/auth_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_category_screen.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_title_screen.dart';
import 'package:rakwa/screens/Auth/Screens/sign_in_screen.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Ads/Screens/ads_screen.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/control_panel_screen.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Home/Screens/home_screen.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/more_screen.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/personal_screen.dart';
import 'package:rakwa/screens/messages_screen/messages_screen.dart';
import 'package:rakwa/screens/save_screen/save_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/widget/main_elevated_button.dart';
import 'package:rakwa/widget/my_drawer.dart';

class MainUserScreen extends StatefulWidget {
  const MainUserScreen({super.key});

  @override
  State<MainUserScreen> createState() => _MainUserScreenState();
}

class _MainUserScreenState extends State<MainUserScreen> with Helpers {
  int selected = 0;

  final List _screens = const [
    HomeScreen(),
    MessagesScreen(),
    MessagesScreen(),
    AdsScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (SharedPrefController().isLogined &&
                SharedPrefController().roleId == 3) {
              // Get.to(() => const AddListCategoryScreen());
            } else if (SharedPrefController().isLogined &&
                SharedPrefController().roleId == 2) {
              alertDialogRoleAuthUser(context);
            } else {
              AlertDialogUnAuthUser(context);
            }
          },
          backgroundColor: Colors.grey,
          child: const Icon(Icons.add)),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
            currentIndex: selected,
            onTap: (value) {
              if (value != 2) {
                if (value != 0 && SharedPrefController().token.isEmpty) {
                  AlertDialogUnAuthUser(context);
                } else {
                  setState(() {
                    selected = value;
                  });
                }
              } else {}
            },
            selectedItemColor: AppColors.mainColor,
            selectedLabelStyle: GoogleFonts.notoKufiArabic(
                textStyle: const TextStyle(color: Colors.white, fontSize: 12)),
            unselectedIconTheme: const IconThemeData(
              color: Colors.white,
            ),
            unselectedLabelStyle: GoogleFonts.notoKufiArabic(
                textStyle: const TextStyle(color: Colors.white, fontSize: 12)),
            backgroundColor: AppColors.bottonNavBarColor,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'الصفحة \nالرئيسية'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message_outlined),
                  activeIcon: Icon(Icons.message),
                  label: 'الرسائل'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.transparent),
                  label: 'اضافة قائمة'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.class_outlined),
                  activeIcon: Icon(Icons.class_),
                  label: 'الاعلانات'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  activeIcon: Icon(Icons.menu),
                  label: 'المزيد'),
            ]),
      ),
      // drawer: MyDrawer(
      //   selected: selected,
      //   homeOnTap: () {
      //     setState(() {
      //       selected = 0;
      //     });
      //     Get.back();
      //   },
      //   adsOnTap: () {
      //     if (SharedPrefController().isLogined) {
      //       setState(() {
      //         selected = 3;
      //       });
      //       Get.back();
      //     } else {
      //       AlertDialogUnAuthUser(context);
      //     }
      //   },
      //   panelOnTap: () {
      //     if (SharedPrefController().isLogined) {
      //       setState(() {
      //         selected = 1;
      //       });
      //       Get.back();
      //     } else {
      //       AlertDialogUnAuthUser(context);
      //     }
      //   },
      //   personalOnTap: () {
      //     if (SharedPrefController().isLogined) {
      //       setState(() {
      //         selected = 4;
      //       });
      //       Get.back();
      //     } else {
      //       AlertDialogUnAuthUser(context);
      //     }
      //   },
      //   contactWithUs: () {},
      //   verifiedEmail: () async {
      //     bool status = await AuthApiController().emailVerification();
      //     if (status) {
      //       Get.snackbar('تمت العملية بنجاح', 'تم تاكيد حسابك',
      //           backgroundColor: Colors.green.shade700);
      //     } else {
      //       Get.snackbar('خطأ', 'حدث خطأ ما',
      //           backgroundColor: Colors.red.shade700);
      //     }
      //     Get.back();
      //   },
      //   logout: () async {
      //     if (SharedPrefController().isLogined) {
      //       bool status = await AuthApiController().logout();
      //       if (status) {
      //         Get.offAllNamed('/sign_in_screen');
      //       }
      //     } else {
      //       Get.offAllNamed('/sign_in_screen');
      //     }
      //   },
      //   myList: () {
      //     if (SharedPrefController().isLogined) {
      //     } else {
      //       AlertDialogUnAuthUser(context);
      //     }
      //   },
      //   rating: () {
      //     if (SharedPrefController().isLogined) {
      //     } else {
      //       AlertDialogUnAuthUser(context);
      //     }
      //   },
      //   saved: () {
      //     if (SharedPrefController().isLogined) {
      //       Get.to(() => const SaveScreen());
      //     } else {
      //       AlertDialogUnAuthUser(context);
      //     }
      //   },
      // ),
      // appBar: selected != 4
      //     ? AppBar(
      //         backgroundColor: Colors.transparent,
      //         elevation: 0,
      //         centerTitle: true,
      //         title: Image.asset(
      //           'images/logo.png',
      //           height: 42,
      //           width: 42,
      //         ),
      //         leadingWidth: 45,
      //         leading: Builder(
      //           builder: (context) {
      //             return InkWell(
      //               onTap: () => Scaffold.of(context).openDrawer(),
      //               child: SharedPrefController().image.isNotEmpty
      //                   ? CircleAvatar(
      //                       radius: 30,
      //                       backgroundColor:
      //                           AppColors.labelColor.withOpacity(0.4),
      //                       backgroundImage: NetworkImage(
      //                           'https://www.rakwa.com/laravel_project/public/storage/user/${SharedPrefController().image}'),
      //                     )
      //                   : const CircleAvatar(
      //                       radius: 30,
      //                       backgroundColor: Colors.transparent,
      //                       backgroundImage:
      //                           AssetImage('images/profile_image.png'),
      //                     ),
      //             );
      //           },
      //         ),
      //       )
      //     : null,
      body: _screens.elementAt(selected),
    );
  }
}
