import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/instance_manager.dart';
import 'package:rakwa/Core/services/network_services.dart';
import 'package:rakwa/Core/utils/network_exceptions.dart';
import 'package:rakwa/api/api_setting/api_setting.dart';

class ChangePasswordRepository {
  final NetworkService _networkService = Get.put(NetworkService());

  Future<Response> changePassword({
    required String id,
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    Response response;

    try {
      response = await _networkService.post(
          url: '${ApiKey.user}$id/update-profile-password',
          body: {
            'password': oldPassword,
            'new_password': newPassword,
            'new_password_confirmation': confirmPassword,
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
