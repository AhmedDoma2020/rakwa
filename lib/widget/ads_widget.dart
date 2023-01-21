import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors/app_colors.dart';

class AdsWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;

  AdsWidget({
    required this.image,
    required this.subTitle,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 213,
      width: Get.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Stack(
            children: [
              image.isNotEmpty
                  ? Image.network(
                      image,
                      fit: BoxFit.fill,
                      width: Get.width,
                    )
                  // : Image.network(
                  //     'https://rakwa.com/theme_assets/frontend_assets/lduruo10_dh_frontend_city_path/placeholder/',
                  //     fit: BoxFit.fill,
                  //     width: Get.width,
                  //   ),
                  : Image.asset(
                      'images/logo.jpg',
                      fit: BoxFit.fill,
                      width: Get.width,
                    ),
              Positioned(
                  left: 13,
                  top: 10,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.save_alt,
                        color: Colors.black,
                      )))
            ],
          )),
          const SizedBox(
            height: 12,
          ),
          Text(
            title,
            style: GoogleFonts.notoKufiArabic(
                textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            )),
          ),
          const SizedBox(
            height: 13,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.blueLightColor),
            child: Text(
              subTitle,
              style: GoogleFonts.notoKufiArabic(
                  textStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              )),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
