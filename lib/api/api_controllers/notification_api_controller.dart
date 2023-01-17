import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:rakwa/api/api_helper/api_helper.dart';
import 'package:rakwa/api/api_setting/api_setting.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';

class NotificationApiController with ApiHelper {
  Future<bool> storeFCMToken(
      {required String fcmToken, required String device}) async {
    Uri uri = Uri.parse(ApiKey.fcmToken);
    var response = await http.post(
      uri,
      headers: headers,
      body: {
        'user_id': SharedPrefController().id,
        'device_id': device,
        'fcm_token': fcmToken
      },
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
