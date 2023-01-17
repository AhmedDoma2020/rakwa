import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors/app_colors.dart';

class LabelText extends StatelessWidget {
  final String text;

  LabelText({required this.text});


  @override
  Widget build(BuildContext context) {
    return Text(text,style: GoogleFonts.notoKufiArabic(
      textStyle:const TextStyle(
        fontSize: 14,
        color: AppColors.labelColor

      )
    ),);
  }
}