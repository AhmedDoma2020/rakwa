import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/widget/SVG_Widget/svg_widget.dart';


class CardMoreScreen extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const CardMoreScreen({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconSvg(
                  icon,
                  size: 28,
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: GoogleFonts.notoKufiArabic(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_back_ios_new_outlined,color: AppColors.mainColor,size: 18,),

          ],
        ),
      ),
    );
  }
}