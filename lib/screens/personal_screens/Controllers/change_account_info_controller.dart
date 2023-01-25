import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:rakwa/Core/services/dialogs.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/screens/main_screens/main_screen.dart';
import 'package:rakwa/screens/personal_screens/Repo/change_account_info_repo.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';
import 'package:rakwa/widget/SnackBar/custom_snack_bar.dart';

class ChangeAccountInfoController extends GetxController {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController countryController;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  final ChangeAccountInfoRepository _changeAccountInfoRepository =
      Get.put(ChangeAccountInfoRepository());
  void changeAccountInfo({ File? file,required String countryId}) async {
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      setLoading();
      var response = await _changeAccountInfoRepository.changeAccountInfo(
        id: SharedPrefController().id,
        name: "${firstNameController.text} ${lastNameController.text}",
        phone: phoneController.text,
        email: emailController.text,
        file: file,
        countryId: countryId ,
      );
      Get.back();
      if (response.statusCode == 200 ) {
        await SharedPrefController().saveData(
          userLoginModel: response.data["data"],
          token: response.data["data"]["api_token"],
          isLogined: true,
        );
        _navigation();
        customSnackBar(title: response.data["message"] ?? "");
      } else {
        showSnakError(response);
      }
    }
  }

  void _navigation() {
    Get.offAll(() => const MainScreen());
  }

  @override
  void onInit() {
    super.onInit();
    printDM('..........>>>> ${SharedPrefController().name.split(" ").elementAt(1)}');
    firstNameController = TextEditingController(text: SharedPrefController().name.split(" ").elementAt(0));
    lastNameController = TextEditingController(text: SharedPrefController().name.split(" ").elementAt(1));
    phoneController = TextEditingController(text: SharedPrefController().phone);
    emailController = TextEditingController(text: SharedPrefController().email);
    countryController = TextEditingController(text: SharedPrefController().countryName);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    countryController.dispose();
    super.dispose();
  }
  void showSnakError(Response response) {
    if(response.data["errors"]["email"][0]!=null){
      customSnackBar(title: response.data["errors"]["email"][0] , isWarning: true);
    }else if(response.data["message"]!=null){
      customSnackBar(title: response.data["message"] , isWarning: true);
    }else{
      customSnackBar(title: "حدث خطاء ما..." , isWarning: true);
    }

  }
}


