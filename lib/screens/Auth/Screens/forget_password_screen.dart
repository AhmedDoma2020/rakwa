import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/api/api_controllers/auth_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/screens/Auth/Controllers/forget_password_controller.dart';
import 'package:rakwa/screens/Auth/Screens/check_code_screen.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/widget/SVG_Widget/svg_widget.dart';
import 'package:rakwa/widget/TextFields/text_field_default.dart';
import 'package:rakwa/widget/TextFields/validator.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/main_elevated_button.dart';
import 'package:rakwa/widget/my_text_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
   ForgetPasswordScreen({super.key});
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPasswordController());
    var node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBars.appBarDefault(
        title: "نسيت كلمة المرور؟",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GetBuilder<ForgetPasswordController>(
          builder: (_) => ListView(
            children: [
              const Center(child: AssetSvg('forgetPassword')),
              const Center(
                child: SizedBox(height: 12),
              ),
              Text(
                'برجاء ادخل بريدك الالكتروني لاسترجاع\n كلمة المرور',
                style: GoogleFonts.notoKufiArabic(
                    textStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 24,
              ),
              Form(
                key: _globalKey,
                child: TextFieldDefault(
                  upperTitle: "البريد الالكتروني",
                  hint: 'ادخل البريد الالكتروني',
                  controller: _.emailController,
                  prefixIconSvg: "Email",
                  // prefixIconData: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validation: emailValidator,
                  onComplete: () {
                    node.unfocus();
                    _.forgetPassword(_globalKey);
                  },
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              MainElevatedButton(
                height: 56,
                width: Get.width,
                borderRadius: 12,
                onPressed: () {
                  node.unfocus();
                  _.forgetPassword(_globalKey);
                },
                child: Text(
                  'ارسال',
                  style: GoogleFonts.notoKufiArabic(
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
