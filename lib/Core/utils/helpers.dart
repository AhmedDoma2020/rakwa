import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/api/api_controllers/auth_api_controller.dart';
import 'package:rakwa/screens/Auth/Screens/sign_in_screen.dart';
import 'package:rakwa/screens/Auth/Screens/user_role_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';

import '../../app_colors/app_colors.dart';

class Helpers {
  Future<String?> AlertDialogUnAuthUser(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: const Text('لم تقم بتسجيل الدخول'),
          content: const Text('هل تريد تسجيل الدخول؟'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('الغاء',
                  style: GoogleFonts.notoKufiArabic(
                      textStyle: const TextStyle(color: AppColors.labelColor))),
            ),
            ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.mainColor),
                ),
                onPressed: () {
                  Get.back();

                  Get.toNamed('/sign_in_screen');
                },
                child: Text('نعم', style: GoogleFonts.notoKufiArabic())),
          ]),
    );
  }

  Future<String?> alertDialogRoleAuthUser(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: const Text('لم تسجل دخول كصاحب عمل'),
          content:
              const Text('هل تريد تسجيل الخروج وانشاء حساب جديد كصاحب عمل ؟'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('الغاء',
                  style: GoogleFonts.notoKufiArabic(
                      textStyle: const TextStyle(color: AppColors.labelColor))),
            ),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
                backgroundColor: MaterialStateProperty.all(AppColors.mainColor),
              ),
              onPressed: () async {
                if (SharedPrefController().isLogined) {
                  bool status = await AuthApiController().logout();
                  if (status) {
                    Get.back();
                    Get.offAll(() => SignInScreen());
                    Get.to(() => const UserRoleScreen());
                  }
                }
              },
              child: Text(
                'نعم',
                style: GoogleFonts.notoKufiArabic(),
              ),
            ),
          ]),
    );
  }

  Future<String?> alertDialogDeletAccount(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: const Text('هل انت متاكد؟'),
          content: const Text('سيتم حدف حسابك بشكل نهائي هل انت متاكد ؟'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('الغاء',
                  style: GoogleFonts.notoKufiArabic(
                      textStyle: const TextStyle(color: AppColors.labelColor))),
            ),
            ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.red.shade700),
                ),
                onPressed: () async {
                  if (SharedPrefController().isLogined) {
                    bool status = await AuthApiController().deleteAccount();
                    if (status) {
                      Get.offAllNamed('/sign_in_screen');
                    }
                  }
                },
                child: Text('نعم', style: GoogleFonts.notoKufiArabic())),
          ]),
    );
  }


}
void ShowMySnakbar({
  required String title,
  required String message,
  SnackPosition? snackPosition,
  Color? backgroundColor,
}) {
  Get.snackbar(title, message,
      snackPosition: snackPosition,
      backgroundColor: backgroundColor,
      colorText: Colors.white);
}