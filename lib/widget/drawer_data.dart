import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors/app_colors.dart';

class DrawerData extends StatelessWidget {
  final int selected;
  final int value;
  final IconData selectedIcon;
  final IconData unSelectedIcon;
  final String text;

  DrawerData({
    required this.selected,
    required this.value,
    required this.selectedIcon,
    required this.unSelectedIcon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 32,
          width: 32,
          decoration: selected == value
              ? BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.mainColor,
                        AppColors.mainColor.withOpacity(0.8),
                        AppColors.mainColor.withOpacity(0.6),
                        Colors.white
                      ]),
                  borderRadius: BorderRadius.circular(10),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
          child: selected == value
              ? Icon(
                  selectedIcon,
                  color: Colors.white,
                )
              : Icon(
                  unSelectedIcon,
                  color: AppColors.drawerColor,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: GoogleFonts.notoKufiArabic(
              textStyle: TextStyle(
                  fontSize: 16,
                  color: selected == value
                      ? AppColors.mainColor
                      : AppColors.drawerColor,
                  fontWeight: FontWeight.w500)),
        )
      ],
    );
  }
}
