import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:rakwa/Core/services/dialogs.dart';
import 'package:rakwa/screens/Auth/Repositories/forget_bassword_repo.dart';
import 'package:rakwa/screens/Auth/Repositories/reset_password_repo.dart';
import 'package:rakwa/screens/Auth/Repositories/send_FCM_token_repo.dart';
import 'package:rakwa/screens/Auth/Repositories/sign_in_repo.dart';
import 'package:rakwa/screens/Auth/Screens/check_code_screen.dart';
import 'package:rakwa/screens/Auth/Screens/user_role_screen.dart';
import 'package:rakwa/screens/personal_screens/Repo/change_password_repo.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';
import 'package:rakwa/widget/SnackBar/custom_snack_bar.dart';

class ChangePasswordController extends GetxController {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final ChangePasswordRepository _changePasswordRepository =
      Get.put(ChangePasswordRepository());

  void changePassword() async {
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      setLoading();
      var response = await _changePasswordRepository.changePassword(
        id: SharedPrefController().id,
        oldPassword: oldPasswordController.text,
        confirmPassword: confirmPasswordController.text,
        newPassword: newPasswordController.text,
      );
      Get.back();
      if (response.statusCode == 200) {
        _navigation();
        customSnackBar(title: response.data["message"] ?? "");
      } else {
        showSnakError(response);
      }
    }
  }

  void _navigation() {
    Get.offAllNamed('/sign_in_screen');
  }

  @override
  void onInit() {
    super.onInit();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void showSnakError(Response response) {
    if (response.data["errors"]["password"][0] != null) {
      customSnackBar(
          title: response.data["errors"]["password"][0], isWarning: true);
    }else if (response.data["errors"]["new_password"][0] != null) {
      customSnackBar(
          title: response.data["errors"]["new_password"][0], isWarning: true);
    } else if (response.data["message"] != null) {
      customSnackBar(title: response.data["message"], isWarning: true);
    } else {
      customSnackBar(title: "حدث خطاء ما...", isWarning: true);
    }
  }
}
