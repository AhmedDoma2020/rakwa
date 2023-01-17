import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app_colors/app_colors.dart';



class HaveOrNotHaveAccount extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onTap;

  const HaveOrNotHaveAccount({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.notoKufiArabic(
            textStyle: const TextStyle(
              fontSize: 14,
              color: AppColors.subTitleColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(4),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
            child: Text(
              subTitle,
              style: GoogleFonts.notoKufiArabic(
                textStyle: const TextStyle(
                  fontSize: 14,
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
