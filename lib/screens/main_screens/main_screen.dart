import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/controller/fb_notifications_controller.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_category_screen.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Home/Screens/home_screen.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Ads/Screens/ads_screen.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/artical_screen.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/more_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';
import 'package:rakwa/Core/utils/helpers.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with Helpers, FBNotificationsController {
  int selected = 0;

  final List _screens = const [
    HomeScreen(),
    ArticalScreen(),
    ArticalScreen(),
    AdsScreen(),
    MoreScreen(),
  ];


  @override
  void initState() {
    super.initState();
    initializeForegroundNotificationForAndroid();
    mangeNotificationAction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 5),
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        height: 55.0,
        width: 55.0,
        child: FloatingActionButton(
            onPressed: () {
              if (SharedPrefController().roleId == 3) {
                if (SharedPrefController().verifiedEmail != 'null') {
                  Get.to(() =>  AddListCategoryScreen());
                } else {
                  ShowMySnakbar(
                      title: 'لم تقم بتاكيد حسابك',
                      message: 'يجب عليك تاكيد حسابك قبل',
                      backgroundColor: Colors.red.shade700);
                }
              } else if (SharedPrefController().roleId == 2) {
                alertDialogRoleAuthUser(context);
              } else {
                AlertDialogUnAuthUser(context);
              }

              // if (SharedPrefController().isLogined &&
              //     SharedPrefController().roleId == 3) {
              //   if (SharedPrefController().verifiedEmail != null) {
              //     Get.to(() => const AddListCategoryScreen());
              //   } else {
              //     ShowMySnakbar(
              //         title: 'لم تقم بتاكيد حسابك',
              //         message: 'يجب عليك تاكيد حسابك قبل',
              //         backgroundColor: Colors.red.shade700);
              //   }
              // } else if (SharedPrefController().isLogined &&
              //     SharedPrefController().roleId == 2) {
              // } else {
              //   AlertDialogUnAuthUser(context);
              // }
            },
            backgroundColor: AppColors.mainColor,
            child: const Icon(
              Icons.add_business_rounded,
              size: 30,
            )),
      ),
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
                textStyle: const TextStyle(color: Colors.black, fontSize: 10)),
            unselectedIconTheme: const IconThemeData(
              color: Colors.grey,
            ),
            unselectedLabelStyle: GoogleFonts.notoKufiArabic(
                textStyle: const TextStyle(color: Colors.grey, fontSize: 10)),
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.black,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.search_rounded),
                  activeIcon: Icon(Icons.search_rounded),
                  label: 'البحث',),
              BottomNavigationBarItem(
                  // icon: Icon(Icons.auto_awesome_mosaic_outlined),
                  // activeIcon: Icon(Icons.auto_awesome_mosaic),
                  icon: Icon(Icons.article_rounded),
                  activeIcon: Icon(Icons.article_rounded),
                  label: 'المقالات'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.transparent),
                  label: 'اضافة عمل'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.class_),
                  activeIcon: Icon(Icons.class_),
                  label: 'إعلانات مبوبة'),
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
      // logout: () async {
      //   if (SharedPrefController().isLogined) {
      //     bool status = await AuthApiController().logout();
      //     if (status) {
      //       Get.offAllNamed('/sign_in_screen');
      //     }
      //   } else {
      //     Get.offAllNamed('/sign_in_screen');
      //   }
      // },
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
      //           'images/logo.jpg',
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

  sendNotification() async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAzSpXY5w:APA91bHWeBH9-v9HNRX5pfPDAsmuJIcrM5U1OP3y6Za1hOlexvlrdQrrjOjudWEEkqXHsSvzXsNItByQQR_UxvM6m2kZZuXh0xo0QNPj6Ct4ZAfFFFwmoOFM1vW_5WMRJ1UGIs0efpmC',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'body',
            'title': 'name send you a message'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': 'token',
        },
      ),
    );
  }
}
