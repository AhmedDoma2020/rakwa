import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/app_colors/app_colors.dart';


class CardAllCategoriesScreen extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const CardAllCategoriesScreen({
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
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 24,
                  child: Center(
                    child: Image.network(
                      'https://www.rakwa.com/laravel_project/public/storage/category/$icon',
                      height: 40,
                      width: 40,
                    ),
                  ),
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