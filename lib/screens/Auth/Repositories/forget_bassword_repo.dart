import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/instance_manager.dart';
import 'package:rakwa/Core/services/network_services.dart';
import 'package:rakwa/Core/utils/network_exceptions.dart';
import 'package:rakwa/api/api_setting/api_setting.dart';

class ForgetPasswordRepository  {
  final NetworkService _networkService = Get.put(NetworkService());
  Future<Response> forgetPassword({
    required String email,
  }) async {
    Response response;
    try {
      response = await _networkService.post(
          url: ApiKey.forgetPassword,
          body: {
            'email': email,
          }
      );
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
