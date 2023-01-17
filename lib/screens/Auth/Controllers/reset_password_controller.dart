import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rakwa/Core/services/dialogs.dart';
import 'package:rakwa/screens/Auth/Repositories/forget_bassword_repo.dart';
import 'package:rakwa/screens/Auth/Repositories/reset_password_repo.dart';
import 'package:rakwa/screens/Auth/Repositories/send_FCM_token_repo.dart';
import 'package:rakwa/screens/Auth/Repositories/sign_in_repo.dart';
import 'package:rakwa/screens/Auth/Screens/check_code_screen.dart';
import 'package:rakwa/screens/Auth/Screens/user_role_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';
import 'package:rakwa/widget/SnackBar/custom_snack_bar.dart';

class ResetPasswordController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final ResetPasswordRepository _resetPasswordRepository =
      Get.put(ResetPasswordRepository());

  void resetPassword({required String code}) async {
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      setLoading();
      var response = await _resetPasswordRepository.resetPassword(
        code: code,
        confirmPassword: confirmPasswordController.text,
        password: passwordController.text,
      );
      Get.back();
      if (response.statusCode == 200) {
        _navigation();
        customSnackBar(title: response.data["message"] ?? "");
      } else {
        customSnackBar(title: response.data["message"] ?? "", isWarning: true);
      }
    }
  }

  void _navigation() {
    Get.offAllNamed('/sign_in_screen');
  }

  @override
  void onInit() {
    super.onInit();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
