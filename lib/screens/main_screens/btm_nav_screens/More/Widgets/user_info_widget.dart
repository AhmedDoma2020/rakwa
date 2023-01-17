import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/personal_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    printDM("SharedPrefController().image is ${SharedPrefController().image}");
    return InkWell(
      onTap: () => Get.to(() => const PersonalScreen()),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.mainColor.withOpacity(.06),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://www.rakwa.com/laravel_project/public/storage/user/${SharedPrefController().image}',
                    height: 80,
                    width: 72,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      "images/defoultAvatar.png",
                      height: 80,
                      width: 72,
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      SharedPrefController().name,
                      style: GoogleFonts.notoKufiArabic(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      SharedPrefController().email,
                      style: GoogleFonts.notoKufiArabic(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 24,
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: AppColors.mainColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
