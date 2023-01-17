import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/instance_manager.dart';
import 'package:rakwa/Core/services/network_services.dart';
import 'package:rakwa/Core/utils/network_exceptions.dart';
import 'package:rakwa/api/api_setting/api_setting.dart';

class ResetPasswordRepository {
  final NetworkService _networkService = Get.put(NetworkService());

  Future<Response> resetPassword({
    required String code,
    required String password,
    required String confirmPassword,
  }) async {
    Response response;

    try {
      response = await _networkService.post(
          url: ApiKey.resetPassword,
          body: {
        'code': code,
        'password': password,
        'confirm_password': confirmPassword
      });
    } on SocketException {
      throw SocketException('No Internet Connection');
    } on Exception {
      throw UnKnownException('there is unKnown Exception');
    } catch (e) {
      throw UnKnownException(e.toString());
    }
    return response;
  }
}
