import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/api/api_controllers/auth_api_controller.dart';
import 'package:rakwa/screens/personal_screens/acount_information_screen.dart';
import 'package:rakwa/screens/personal_screens/address_screen.dart';
import 'package:rakwa/screens/personal_screens/change_password_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/drawer_data.dart';

import '../../../app_colors/app_colors.dart';
import '../../../widget/my_text_field.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> with Helpers {
  late TextEditingController _searchController;
  final List actions = [
    ['images/user_icon.png', 'معلومات الحساب'],
    // ['images/address_icon.png', 'العنوان'],
    ['images/password_icon.png', 'كلمة المرور'],
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarDefault(title: "الصفحة الشخصية"),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
            color: Colors.white,
            child: Row(
              children: [
                SharedPrefController().image.isNotEmpty
                    ? CircleAvatar(
                        backgroundColor: AppColors.labelColor.withOpacity(0.4),
                        backgroundImage: NetworkImage(
                            'https://www.rakwa.com/laravel_project/public/storage/user/${SharedPrefController().image}'),
                        radius: 50,
                      )
                    : const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage('images/defoultAvatar.png'),
                        radius: 50,
                      ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  children: [
                    Text(
                      SharedPrefController().name,
                      style: GoogleFonts.notoKufiArabic(
                          textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      SharedPrefController().email,
                      style: GoogleFonts.notoKufiArabic(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.viewAllColor)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الحساب',
                  style: GoogleFonts.notoKufiArabic(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  'تحديث المعلومات الخاصة بك للحفاظ على حسابك',
                  style: GoogleFonts.notoKufiArabic(
                      textStyle: const TextStyle(
                          fontSize: 14, color: AppColors.viewAllColor)),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: ListView.separated(
                padding: EdgeInsets.zero,
              shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      onTap: () {
                        if (index == 0) {
                          Get.to(() => const AccountInformationScreen());
                        }
                        // else if (index == 1) {
                        //    Get.to(() => const AddressScreen());
                        // }
                        else {
                          Get.to(() => const PasswordScreen());
                        }
                      },
                      leading: Image.asset(actions[index][0]),
                      title: Text(
                        actions[index][1],
                        style: GoogleFonts.notoKufiArabic(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: AppColors.viewAllColor,
                  );
                },
                itemCount: actions.length),
          ),

          const SizedBox(
            height: 32,
          ),


        ],
      ),
    );
  }
}