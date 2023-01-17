import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/instance_manager.dart';
import 'package:rakwa/Core/services/network_services.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/Core/utils/network_exceptions.dart';
import 'package:rakwa/api/api_setting/api_setting.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';

class SendFCMTokenRepository {
  final NetworkService _networkService = Get.put(NetworkService());
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  String device = Platform.isAndroid ? 'ANDROID' : 'IOS';

  Future<Response> sendFCMToken() async {
    Response response;
    String? token = '';
    try{
      token = await _fcm.getToken();
    }catch(e){
      printDM('an error occur in fetch token');
    }
    try {
      response = await _networkService.post(
          url: ApiKey.fcmToken,
          body: {
            'user_id': SharedPrefController().id,
            'fcm_token': token,
            'device_id': device,
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
