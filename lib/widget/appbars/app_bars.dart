import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/widget/SVG_Widget/svg_widget.dart';

class AppBars {
  static AppBar appBarDefault(
      {bool isBack = true,
      bool isLogo = false,
      TabBar? tabBar,
      String title = '',
      Widget secondIconImage = const SizedBox(
        width: 0,
      ),
      VoidCallback? onTap}) {
    return AppBar(
      title: isLogo
          ? const IconPng(
              'rakwaLogo',
              size: 42,
            )
          : Text(
              title,
              style: GoogleFonts.notoKufiArabic(
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                ),
              ),
            ),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0.0,
      leading: isBack == false
          ? const SizedBox()
          : IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Directionality(
                textDirection: TextDirection.ltr,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
      actions: [
        secondIconImage,
      ],
      bottom: tabBar,
    );
  }
}
