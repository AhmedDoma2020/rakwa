import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/widget/SVG_Widget/svg_widget.dart';

class ControlPanelWidget extends StatelessWidget {
  final String count;
  final String title;
  final String iconURL;
  final Color color;

  ControlPanelWidget(
      {required this.count,
      required this.title,
      required this.iconURL,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      height: 82,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
        // gradient: LinearGradient(
        //   begin: Alignment.centerRight,
        //   end: Alignment.centerLeft,
        //   colors: [
        //     AppColors.mainColor,
        //     AppColors.mainColor.withOpacity(0.8),
        //     AppColors.mainColor.withOpacity(0.5),
        //   ],
        // ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.notoKufiArabic(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                count,
                style: GoogleFonts.notoKufiArabic(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          Container(
            height: 32,
            width: 32,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: IconSvg(
                iconURL,
                size: 20,
                color: color,
              ),
            ),
          )
        ],
      ),
    );
  }
}