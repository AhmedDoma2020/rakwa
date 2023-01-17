import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/instance_manager.dart';
import 'package:rakwa/Core/services/network_services.dart';
import 'package:rakwa/Core/utils/network_exceptions.dart';
import 'package:rakwa/api/api_setting/api_setting.dart';

class ChangeAccountInfoRepository {
  final NetworkService _networkService = Get.put(NetworkService());

  Future<Response> changeAccountInfo({
    required String id,
    required String name,
    required String phone,
    required String email,
    required String countryId,
    required File? file,

  }) async {
    Response response;
    try {
      response = await _networkService.post(
        url:'${ApiKey.user}$id/update-profile',
        // responseType:  ResponseType.bytes,
        isForm: true,
        fileKey: "user_image",
        fileName: "user_image",
        fileList: file!=null? [file]:null,
        body: {
          'name': name,
          'email': email,
          'phone': phone,
          'user_prefer_country_id': countryId,
          'user_prefer_language': "ar",
        },
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
