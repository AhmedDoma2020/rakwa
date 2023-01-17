import 'package:get/get.dart';
import 'package:rakwa/api/api_controllers/home_api_controller.dart';
import 'package:rakwa/model/user_login_model.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';

class EmailVerifiedGetxController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    emailVerified();
  }

  emailVerified() async {
    UserLoginModel? userLoginModel = await HomeApiController().emailVerified();
    if (userLoginModel != null) {
      SharedPrefController().setVerifiedEmail(
        emailVerification: userLoginModel.emailVerifiedAt.toString(),
      );
    }
    update();
  }
}
