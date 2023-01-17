import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/screens/contact_about_screens/privacy_policy_screen.dart';



class AcceptPrivacyRegisterWidget extends StatelessWidget {
  const AcceptPrivacyRegisterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => const PrivacyPolicyScreen());
      },
      borderRadius: BorderRadius.circular(8),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'إنشاء حساب يعني أنك موافق على ',
          style: GoogleFonts.notoKufiArabic(
            textStyle: const TextStyle(
              fontSize: 14,
              color: AppColors.subTitleColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          children: <TextSpan>[
            TextSpan(
              text: ' شروط الخدمة وسياسة الخصوصية',
              style: GoogleFonts.notoKufiArabic(
                textStyle: const TextStyle(
                  fontSize: 14,
                  color: AppColors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
