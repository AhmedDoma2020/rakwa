import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/api/api_controllers/profile_api_controller.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/personal_screen.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/screens/personal_screens/Controllers/change_password_controller.dart';
import 'package:rakwa/widget/TextFields/text_field_default.dart';
import 'package:rakwa/widget/TextFields/validator.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';

import '../../app_colors/app_colors.dart';
import '../../shared_preferences/shared_preferences.dart';
import '../../widget/main_elevated_button.dart';
import '../../widget/my_text_field.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChangePasswordController());
    var node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBars.appBarDefault(title: "تغير كلمة المرور"),
      body: GetBuilder<ChangePasswordController>(
        builder: (_) => Form(
          key: _.globalKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 24,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'نشاطك الأحير وبيانات اعتمادك',
                  style: GoogleFonts.notoKufiArabic(
                      textStyle: const TextStyle(
                          fontSize: 14, color: AppColors.viewAllColor)),
                ),
              ),
              const SizedBox(height: 24),
              TextFieldDefault(
                upperTitle: "كلمة المرور الحالية",
                hint: 'ادخل كلمه المرور الحالية',
                controller: _.oldPasswordController,
                secureType: SecureType.Toggle,
                prefixIconSvg: "Password",
                keyboardType: TextInputType.visiblePassword,
                validation: passwordValidator,
                onComplete: () {
                  node.nextFocus();
                },
              ),
              const SizedBox(height: 16),
              TextFieldDefault(
                upperTitle: "كلمة المرور الجديدة",
                hint: 'ادخل كلمه المرور الجديدة',
                controller: _.newPasswordController,
                secureType: SecureType.Toggle,
                prefixIconSvg: "Password",
                keyboardType: TextInputType.visiblePassword,
                validation: passwordValidator,
                onComplete: () {
                  node.nextFocus();
                },
              ),
              const SizedBox(height: 16),
              TextFieldDefault(
                upperTitle: "تأكيد كلمة المرور",
                hint: 'ادخل كلمه المرور الجديدة',
                controller: _.confirmPasswordController,
                secureType: SecureType.Toggle,
                prefixIconSvg: "Password",
                keyboardType: TextInputType.visiblePassword,
                validation: (value) {
                  return confirmPasswordValidator(
                      value, _.newPasswordController.text);
                },
                onComplete: () {
                  node.unfocus();
                  _.changePassword();
                },
              ),
              const SizedBox(height: 32),
              MainElevatedButton(
                height: 56,
                width: Get.width,
                borderRadius: 12,
                onPressed: () {
                  node.unfocus();
                  _.changePassword();
                },
                child: Text(
                  'حفظ التغيرات',
                  style: GoogleFonts.notoKufiArabic(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
