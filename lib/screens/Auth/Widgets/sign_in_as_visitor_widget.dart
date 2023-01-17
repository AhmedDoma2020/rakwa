

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/widget/Buttons/button_default.dart';

class SignInAsVisitor extends StatelessWidget {
  const SignInAsVisitor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonDefault(
      onTap: () {
        Get.toNamed('/main_screen');
      },
      title: 'تسجيل الدخول كضيف',
      titleColor: AppColors.mainColor,
      titleSize: 12,
      buttonColor: Colors.transparent,
      width: 120,
    );
  }
}
