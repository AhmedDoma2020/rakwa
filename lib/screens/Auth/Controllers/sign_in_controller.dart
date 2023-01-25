import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rakwa/Core/services/dialogs.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_controllers/auth_api_controller.dart';
import 'package:rakwa/screens/Auth/Repositories/send_FCM_token_repo.dart';
import 'package:rakwa/screens/Auth/Repositories/sign_in_repo.dart';
import 'package:rakwa/screens/Auth/Screens/user_role_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';
import 'package:rakwa/widget/SnackBar/custom_snack_bar.dart';

class SignInController extends GetxController {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final SignInRepository _signInRepository = Get.put(SignInRepository());
  final SendFCMTokenRepository _sendFCMTokenRepository =
      Get.put(SendFCMTokenRepository());

  void submit() async {
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      setLoading();
      var response = await _signInRepository.logIn(
        email: emailController!.text,
        password: passwordController!.text,
      );
      Get.back();
      if (response.statusCode == 200 && response.data["code"] == 200) {
        await SharedPrefController().saveData(
          userLoginModel: response.data["user"],
          token: response.data["token"],
          isLogined: true,
        );
        customSnackBar(title: response.data["message"] ?? "");
        _sendFCMToken();
      } else {
        customSnackBar(title: response.data["message"] ?? "", isWarning: true);
      }
    }
  }

  void _sendFCMToken() async {
    var response = await _sendFCMTokenRepository.sendFCMToken();
    Get.offAllNamed('/main_screen');
  }


  void moveToForgetPassword() {
    Get.toNamed('/forget_password_screen');
  }

  void moveToRegister() {
    Get.to(() => const UserRoleScreen());
  }

  @override
  void onInit() {
    super.onInit();
    // emailController = TextEditingController(text: "adoma3015@gmail.com");
    // passwordController = TextEditingController(text: "password");
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController?.dispose();
    passwordController?.dispose();
    super.dispose();
  }
}
