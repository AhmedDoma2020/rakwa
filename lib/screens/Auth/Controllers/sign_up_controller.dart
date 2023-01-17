import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rakwa/Core/services/dialogs.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/screens/Auth/Repositories/send_FCM_token_repo.dart';
import 'package:rakwa/screens/Auth/Repositories/sign_in_repo.dart';
import 'package:rakwa/screens/Auth/Repositories/sign_up_repo.dart';
import 'package:rakwa/screens/Auth/Screens/user_role_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';
import 'package:rakwa/widget/SnackBar/custom_snack_bar.dart';

class SignUpController extends GetxController {

  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? phoneController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final SignUpRepository _signUpRepository = Get.put(SignUpRepository());

  void signUp({required int roleId}) async {
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      setLoading();
      var response = await _signUpRepository.signUp(
        roleId: roleId,
        name: "${firstNameController!.text} ${lastNameController!.text}",
        phone: phoneController!.text,
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
        printDM("countryName is => ${SharedPrefController().countryName}");
        _navigation();
        customSnackBar(title: response.data["message"] ?? "");
      } else {
        customSnackBar(title: response.data["errors"]["email"][0] ?? "", isWarning: true);
      }
    }
  }

  void _navigation() {
    Get.offAllNamed('/sign_in_screen');
  }

  @override
  void onInit() {
    super.onInit();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    firstNameController?.dispose();
    lastNameController?.dispose();
    phoneController?.dispose();
    emailController?.dispose();
    passwordController?.dispose();
    super.dispose();
  }
}
