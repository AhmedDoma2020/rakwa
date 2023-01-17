import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/app_colors/app_colors.dart';


void customSnackBar({bool isWarning =false ,String title = '', String subtitle = '',void Function(SnackbarStatus?)? snackBarStatus}) {
  Get.snackbar(
    '',
    '',
    backgroundColor: isWarning ?Colors.red.shade700:Colors.green.shade400,
    snackPosition: SnackPosition.TOP,
    titleText:
    Text(
      title,
      style: GoogleFonts.notoKufiArabic(
        textStyle: const TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    messageText:
    Text(
      subtitle,
      style: GoogleFonts.notoKufiArabic(
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    snackbarStatus: snackBarStatus,
  );
}
