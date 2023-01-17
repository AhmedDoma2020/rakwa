import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/screens/Auth/Controllers/reset_password_controller.dart';
import 'package:rakwa/widget/TextFields/text_field_default.dart';
import 'package:rakwa/widget/TextFields/validator.dart';

import '../../../api/api_controllers/auth_api_controller.dart';
import '../../../widget/label_text.dart';
import '../../../widget/main_elevated_button.dart';
import '../../../widget/my_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String code;

  const ResetPasswordScreen({super.key, required this.code});


  @override
  Widget build(BuildContext context) {
    Get.put(ResetPasswordController());
    var node = FocusScope.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GetBuilder<ResetPasswordController>(
          builder:(_) =>  Form(
            key: _.globalKey,
            child: ListView(
              children: [
                const SizedBox(height: 24),
                Center(
                  child: Image.asset(
                    'images/logo.png',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: Text(
                    'اعادة تعيين كلمة المرور',
                    style: GoogleFonts.notoKufiArabic(
                      textStyle:
                          const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 24,
                ),
                TextFieldDefault(
                  upperTitle: "كلمة المرور الجديدة",
                  hint: 'ادخل كلمه المرور الجديدة',
                  controller: _.passwordController,
                  secureType: SecureType.Toggle,
                  prefixIconSvg: "Password",
                  // prefixIconData: Icons.lock_outline,
                  validation: passwordValidator,
                  onComplete: () {
                    node.unfocus();
                  },
                ),
                const SizedBox(height: 16),
                TextFieldDefault(
                  upperTitle: "تأكيد كلمة المرور",
                  hint: 'ادخل كلمه المرور الجديدة',
                  controller: _.confirmPasswordController,
                  secureType: SecureType.Toggle,
                  prefixIconSvg: "Password",
                  // prefixIconData: Icons.lock_outline,
                  validation: (value) {
                    return confirmPasswordValidator(
                        value, _.passwordController.text);
                  },
                  onComplete: () {
                    node.unfocus();
                    _.resetPassword(code: code);
                  },
                ),
                const SizedBox(height: 48),
                MainElevatedButton(
                  height: 56,
                  width: Get.width,
                  borderRadius: 12,
                  onPressed: (){
                    _.resetPassword(code: code);
                  },
                  child: Text(
                    'تعيين كلمة المرور',
                    style: GoogleFonts.notoKufiArabic(
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
