import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/personal_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';


class AvatarWidget extends StatelessWidget {
  final double radius;
  const AvatarWidget({
    this.radius=25,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => const PersonalScreen());
      },
      borderRadius: BorderRadius.circular(777),
      child: Center(
        child: SharedPrefController().image.isNotEmpty
            ? CircleAvatar(
          backgroundColor: AppColors.labelColor.withOpacity(0.4),
          backgroundImage:
          NetworkImage('https://www.rakwa.com/laravel_project/public/storage/user/${SharedPrefController().image}'),
          radius: radius,
        )
            :  CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('images/profile_image.png'),
          radius: radius,
        ),
      ),
    );
  }
}