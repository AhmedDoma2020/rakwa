import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_controllers/home_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/controller/location_controller.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/personal_screen.dart';
import 'package:rakwa/screens/nearby_screen/nearby_screen.dart';
import 'package:rakwa/screens/view_all_item_screens/view_all_nearest_item_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';

class TopHomeScreenWidget extends StatelessWidget {
  const TopHomeScreenWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 20,
          child: FutureBuilder<String?>(
            future: HomeApiController().getBackgroundImage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Image.asset(
                  'images/hoem.png',
                  fit: BoxFit.cover,
                  width: Get.width,
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return Image.network(
                  snapshot.data!,
                  width: Get.width,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    'images/hoem.png',
                    fit: BoxFit.cover,
                    width: Get.width,
                  ),
                );
              } else {
                return Image.asset(
                  'images/hoem.png',
                  fit: BoxFit.cover,
                  width: Get.width,
                );
              }
            },
          ),
        ),
        Positioned.fill(
          bottom: 20,
          child: Opacity(
            opacity: 0.25,
            child: Container(
              color: const Color(0xFF000000),
            ),
          ),
        ),
        Positioned(
          top: Get.height * .13,
          right: 16,
          child: Column(
            children: [
              Text(
                '?????? ???????? ????????????',
                style: GoogleFonts.notoKufiArabic(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              6.ESH(),
              InkWell(
                onTap: () async {
                  Get.to(
                    () => ViewAllNearestItemScreen(),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '?????????? ???????????? ??????',
                        style: GoogleFonts.notoKufiArabic(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      8.ESW(),
                      const Icon(
                        Icons.location_on_rounded,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: Get.height * .05,
          left: 24,
          child: InkWell(
            onTap: () {
              Get.to(() => const PersonalScreen());
            },
            child: Center(
              child: SharedPrefController().image.isNotEmpty
                  ? CircleAvatar(
                      backgroundColor: AppColors.labelColor.withOpacity(0.4),
                      backgroundImage: NetworkImage(
                          'https://www.rakwa.com/laravel_project/public/storage/user/${SharedPrefController().image}'),
                      radius: 25,
                    )
                  : const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('images/defoultAvatar.png'),
                      radius: 25,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
