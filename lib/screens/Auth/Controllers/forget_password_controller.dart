import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rakwa/Core/services/dialogs.dart';
import 'package:rakwa/screens/Auth/Repositories/forget_bassword_repo.dart';
import 'package:rakwa/screens/Auth/Repositories/send_FCM_token_repo.dart';
import 'package:rakwa/screens/Auth/Repositories/sign_in_repo.dart';
import 'package:rakwa/screens/Auth/Screens/check_code_screen.dart';
import 'package:rakwa/screens/Auth/Screens/user_role_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';
import 'package:rakwa/widget/SnackBar/custom_snack_bar.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController? emailController;
  final ForgetPasswordRepository _forgetPasswordRepository =
      Get.put(ForgetPasswordRepository());

  void forgetPassword(GlobalKey<FormState> key) async {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      setLoading();
      var response = await _forgetPasswordRepository.forgetPassword(
        email: emailController!.text,
      );
      Get.back();
      if (response.statusCode == 200) {
        _navigation();
        customSnackBar(title: response.data["message"] ?? "");
      } else {
        customSnackBar(
            title: response.data["errors"]["email"][0] ?? "", isWarning: true);
      }
    }
  }

  void _navigation() {
    Get.to(() => const CheckCodeScreen());
  }

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController?.dispose();
    super.dispose();
  }
}
