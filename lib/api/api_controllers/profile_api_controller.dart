import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:rakwa/api/api_helper/api_helper.dart';
import 'package:rakwa/Core/utils/helpers.dart';

import '../../shared_preferences/shared_preferences.dart';
import '../api_setting/api_setting.dart';
import 'package:http/http.dart' as http;

class ProfileApiController with ApiHelper, Helpers {
  Future<bool> updatePassword({
    required String id,
    required String password,
    required String newPassword,
  }) async {
    Uri uri = Uri.parse('${ApiKey.user}$id/update-profile-password');
    var response = await http.post(
      uri,
      headers: headers,
      body: {
        'password': password,
        'new_password': newPassword,
        'new_password_confirmation': newPassword,
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var updataedModel = jsonResponse['data'];
      SharedPrefController().saveData(
          userLoginModel: updataedModel,
          token: updataedModel['api_token'] ?? '',
          isLogined: true);
      return true;
    }
    return false;
  }

  Future<bool> updateData({
    required String id,
    required String name,
    required String email,
    required String countryID,
    required dynamic filePath,
  }) async {
    Uri uri = Uri.parse('${ApiKey.user}$id/update-profile');

    var requset = http.MultipartRequest('POST', uri);
    requset.headers['Accept'] = 'application/json';

    print(
        '============================= $name //,/,///   $email   ////,/,//, $filePath ============================');

    if (filePath != null) {
      var image = await http.MultipartFile.fromPath('user_image', filePath);
      requset.files.add(image);
    }
    dynamic body = '';

    requset.fields['name'] =
        name.isNotEmpty ? name : SharedPrefController().name;
    requset.fields['email'] =
        email.isNotEmpty ? email : SharedPrefController().email;
    requset.fields['user_prefer_language'] = 'ar';
    requset.fields['user_prefer_country_id'] = countryID;
    var response = await requset.send();

    response.stream.transform(utf8.decoder).listen((value) {
      if (response.statusCode == 200) {
        body = jsonDecode(value);
        print('$value ===========================');
        var updataedModel = body['data'];
        SharedPrefController().saveData(
          userLoginModel: updataedModel,
          token: updataedModel['api_token'],
          isLogined: true,
        );
      } else {
        ShowMySnakbar(
          title: 'خطا',
          message: body['message'],
          backgroundColor: Colors.red.shade700,
        );
      }
    });

    if (response.statusCode == 200) {
      return true;
    }
    // return false;
    return false;
  }

// Future<bool> updateData({
//   required String id,
//   required String name,
//   required String email,
//   required String countryID,
//   required var image,
// }) async {
//   Uri uri = Uri.parse('${ApiSetting.update}$id/update-profile');
//   var response = await http.post(uri, headers: headers, body: {
//     'name': name,
//     'email': email,
//     'user_prefer_language': 'ar',
//     'user_prefer_country_id': countryID,
//     'user_image': image
//   });

//   if (response.statusCode == 200) {
//     var jsonResponse = jsonDecode(response.body);
//     var updataedModel = jsonResponse['data'];
//     SharedPrefController().saveData(
//         userLoginModel: updataedModel,
//         token: updataedModel['api_token'] ?? '',
//         isLogined: true);
//     return true;
//   }
//   var jsonResponse = jsonDecode(response.body);
//   print(jsonResponse['message']);
//   print('===================================');
//   return false;
// }
}
