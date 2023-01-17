import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_helper/api_helper.dart';
import 'package:rakwa/api/api_setting/api_setting.dart';
import 'package:rakwa/model/register_model.dart';
import 'package:rakwa/screens/Auth/Screens/sign_in_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';
import 'package:rakwa/Core/utils/helpers.dart';

class AuthApiController with ApiHelper, Helpers {
  Future<bool> register(
      {required RegisterModel registerModel, required int roleId}) async {
    print('=====================');
    Uri uri;
    if (roleId == 3) {
      uri = Uri.parse(ApiKey.register);
    } else {
      uri = Uri.parse(ApiKey.registerUser);
    }
    var response =
        await http.post(uri, headers: headers, body: registerModel.toJson());

    print(response.statusCode);
    var error = jsonDecode(response.body);
    print(error);

    if (response.statusCode == 200) {
      return true;
    } else {
      Get.back();

      ShowMySnakbar(
          title: error['message'].toString(),
          message: error['errors'].toString(),
          backgroundColor: Colors.red.shade700);
      return false;
    }
  }

  Future<bool> emailVerification() async {
    Uri uri = Uri.parse(ApiKey.emailVerification);
    var response = await http.post(uri, headers: tokenKey);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // SharedPrefController()
      //     .setVerifiedEmail(emailVerification: 'emailVerification');
      return true;
    }
    return false;
  }

  Future<bool> login({required String email, required String password}) async {
    Uri uri = Uri.parse(ApiKey.login);
    var response = await http.post(uri, headers: headers, body: {
      'email': email,
      'password': password,
    });
    printDM("response is => ${response.body}");

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      await SharedPrefController().saveData(
        userLoginModel: jsonResponse["user"],
        token: jsonResponse["token"],
        isLogined: true,
      );
      return true;
    }
    ShowMySnakbar(
        title: 'خطأ',
        message: jsonResponse['message'],
        backgroundColor: Colors.red.shade700);
    return false;
  }

  Future<bool> logout() async {
    printDM("response is => tap");
    Uri uri = Uri.parse(ApiKey.logout);
    var response = await http.post(uri, headers: tokenKey);
    printDM("response is => ${response.body}");
    if (response.statusCode == 200) {
      await SharedPrefController().clear();
    Get.offAll(() => SignInScreen());
      return true;
    }
    await SharedPrefController().clear();
    Get.offAll(() => SignInScreen());
    return false;
  }

  Future<bool> deleteAccount() async {
    Uri uri = Uri.parse('${ApiKey.user}${SharedPrefController().id}/destroy');
    var response = await http.post(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      await SharedPrefController().clear();
      Get.offAllNamed('/sign_in_screen');
      return true;
    }

    return false;
  }

  Future<bool> forgetPassword({required String email}) async {
    Uri uri = Uri.parse(ApiKey.forgetPassword);
    var response = await http.post(
      uri,
      headers: headers,
      body: {
        'email': email,
      },
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> checkCode({required String code}) async {
    Uri uri = Uri.parse(ApiKey.checkCode);
    var response = await http.post(uri, headers: headers, body: {'code': code});
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> resetPassword(
      {required String code,
      required String password,
      required String confirmPassword}) async {
    Uri uri = Uri.parse(ApiKey.resetPassword);
    var response = await http.post(uri, headers: headers, body: {
      'code': code,
      'password': password,
      'confirm_password': confirmPassword
    });
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
