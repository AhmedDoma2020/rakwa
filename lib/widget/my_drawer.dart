import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/screens/main_screens/main_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';

import '../app_colors/app_colors.dart';
import 'drawer_data.dart';

class MyDrawer extends StatelessWidget {
  final int selected;
  void Function() homeOnTap;
  void Function() panelOnTap;
  void Function() adsOnTap;
  void Function() personalOnTap;
  void Function() myList;
  void Function() rating;
  void Function() saved;
  void Function() contactWithUs;
  void Function() logout;
  void Function()? verifiedEmail;

  MyDrawer({
    required this.selected,
    required this.homeOnTap,
    required this.adsOnTap,
    required this.panelOnTap,
    required this.personalOnTap,
    required this.myList,
    required this.contactWithUs,
    required this.logout,
    required this.rating,
    required this.saved,
    this.verifiedEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 44,
            ),
            Center(
              child: SharedPrefController().image.isNotEmpty
                  ? CircleAvatar(
                      backgroundColor: AppColors.labelColor.withOpacity(0.4),
                      backgroundImage: NetworkImage(
                          'https://www.rakwa.com/laravel_project/public/storage/user/${SharedPrefController().image}'),
                      radius: 40,
                    )
                  : const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('images/profile_image.png'),
                      radius: 70,
                    ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'مرحيا \n ${SharedPrefController().name} ',
              style: GoogleFonts.notoKufiArabic(
                  textStyle: const TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: homeOnTap,
              child: DrawerData(
                  selected: selected,
                  value: 0,
                  selectedIcon: Icons.home,
                  unSelectedIcon: Icons.home_outlined,
                  text: 'الصفحة الرئيسية'),
            ),
            const SizedBox(
              height: 22,
            ),
            InkWell(
              onTap: panelOnTap,
              child: DrawerData(
                  selected: selected,
                  value: 1,
                  selectedIcon: Icons.candlestick_chart,
                  unSelectedIcon: Icons.candlestick_chart_outlined,
                  text: 'لوحة التحكم '),
            ),
            const SizedBox(
              height: 22,
            ),
            InkWell(
              onTap: adsOnTap,
              child: DrawerData(
                  selected: selected,
                  value: 3,
                  selectedIcon: Icons.class_,
                  unSelectedIcon: Icons.class_outlined,
                  text: 'الاعلانات'),
            ),
            const SizedBox(
              height: 22,
            ),
            InkWell(
              onTap: personalOnTap,
              child: DrawerData(
                  selected: selected,
                  value: 4,
                  selectedIcon: Icons.person,
                  unSelectedIcon: Icons.person_outlined,
                  text: 'الصفحة الشخصية'),
            ),
            const SizedBox(
              height: 22,
            ),
            InkWell(
              onTap: myList,
              child: DrawerData(
                  selected: selected,
                  value: 10,
                  selectedIcon: Icons.list,
                  unSelectedIcon: Icons.list,
                  text: 'قائمتي'),
            ),
            const SizedBox(
              height: 22,
            ),
            InkWell(
              onTap: rating,
              child: DrawerData(
                  selected: selected,
                  value: 10,
                  selectedIcon: Icons.star_border,
                  unSelectedIcon: Icons.star_border,
                  text: 'التقييمات '),
            ),
            const SizedBox(
              height: 22,
            ),
            InkWell(
              onTap: saved,
              child: DrawerData(
                  selected: selected,
                  value: 10,
                  selectedIcon: Icons.bookmark_outline_sharp,
                  unSelectedIcon: Icons.bookmark_outline_sharp,
                  text: 'القائمات المحفوظة'),
            ),
            const SizedBox(
              height: 22,
            ),
            InkWell(
              onTap: contactWithUs,
              child: DrawerData(
                  selected: selected,
                  value: 10,
                  selectedIcon: Icons.headphones,
                  unSelectedIcon: Icons.headphones,
                  text: 'تواصل معنا'),
            ),
            const SizedBox(
              height: 32,
            ),

            Visibility(
                visible: SharedPrefController().roleId == 3 &&
                    SharedPrefController().verifiedEmail == null,
                child: InkWell(
                    onTap: verifiedEmail,
                    child: DrawerData(
                        selected: selected,
                        value: 10,
                        selectedIcon: Icons.email_outlined,
                        unSelectedIcon: Icons.email_outlined,
                        text: 'تاكيد الحساب'))),
            const SizedBox(
              height: 32,
            ),

            // InkWell(
            //   onTap: verifiedEmail,
            //   child: SharedPrefController().roleId ==3 && SharedPrefController().verifiedEmail == null
            //       ? DrawerData(
            //           selected: selected,
            //           value: 10,
            //           selectedIcon: Icons.logout,
            //           unSelectedIcon: Icons.logout,
            //           text: 'تسجيل الخروج ')
            //       : DrawerData(
            //           selected: selected,
            //           value: 10,
            //           selectedIcon: Icons.login,
            //           unSelectedIcon: Icons.login,
            //           text: 'تسجيل الدخول '),
            // ),

            InkWell(
              onTap: logout,
              child: SharedPrefController().isLogined
                  ? DrawerData(
                      selected: selected,
                      value: 10,
                      selectedIcon: Icons.logout,
                      unSelectedIcon: Icons.logout,
                      text: 'تسجيل الخروج ')
                  : DrawerData(
                      selected: selected,
                      value: 10,
                      selectedIcon: Icons.login,
                      unSelectedIcon: Icons.login,
                      text: 'تسجيل الدخول '),
            ),
          ],
        ),
      ),
    );
  }
}
