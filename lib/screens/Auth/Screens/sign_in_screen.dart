import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/controller/fb_notifications_controller.dart';
import 'package:rakwa/screens/Auth/Controllers/sign_in_controller.dart';
import 'package:rakwa/screens/Auth/Widgets/have_or_not_have_account.dart';
import 'package:rakwa/screens/Auth/Widgets/sign_in_as_visitor_widget.dart';
import 'package:rakwa/widget/Buttons/button_default.dart';
import 'package:rakwa/widget/TextFields/text_field_default.dart';
import 'package:rakwa/widget/TextFields/validator.dart';
import 'package:rakwa/widget/main_elevated_button.dart';

class SignInScreen extends StatelessWidget with FBNotificationsController {
  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignInController());
    var node = FocusScope.of(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,),
        child: KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible) {
            return GetBuilder<SignInController>(
              builder: (_) => Form(
                key: _.globalKey,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  // shrinkWrap: true,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 48.h,
                    ),
                    Center(
                      child: Image.asset(
                        'images/logo.png',
                        height: 73,
                        width: 73,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Center(
                      child: Text(
                        'تسجيل الدخول',
                        style: GoogleFonts.notoKufiArabic(
                          textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFieldDefault(
                      upperTitle: "البريد الالكتروني",
                      hint: 'ادخل البريد الالكتروني',
                      prefixIconSvg: "Email",
                      // prefixIconData: Icons.email_outlined,
                      controller: _.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validation: userNameValidator,
                      onComplete: () {
                        node.nextFocus();
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFieldDefault(
                      upperTitle: "كلمة المرور",
                      hint: 'ادخل كلمه المرور',
                      controller: _.passwordController,
                      secureType: SecureType.Toggle,
                      prefixIconSvg: "Password",
                      // prefixIconData: Icons.lock_outline,
                      validation: passwordValidator,
                      onComplete: () {
                        node.unfocus();
                        _.submit();
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        ButtonDefault(
                          onTap: () {
                            _.moveToForgetPassword();
                          },
                          title: 'نسيت كلمة المرور ؟',
                          titleColor: Colors.black,
                          titleSize: 12,
                          buttonColor: Colors.transparent,
                          width: 120,
                        ),
                      ],
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
                        _.submit();
                      },
                      child: Text(
                        'تسجيل الدخول',
                        style: GoogleFonts.notoKufiArabic(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        SizedBox(),
                        SignInAsVisitor(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    HaveOrNotHaveAccount(
                      title: 'لا تمتلك حساب؟',
                      subTitle: 'قم بإنشاء حساب',
                      onTap: () {
                       _.moveToRegister();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}


