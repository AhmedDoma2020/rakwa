import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rakwa/api/api_helper/api_helper.dart';
import 'package:rakwa/api/api_setting/api_setting.dart';
import 'package:rakwa/model/all_messages_model.dart';
import 'package:rakwa/model/messages_model.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';

class MessagesApiCpntroller with ApiHelper {
  Future<List<AllMessagesModel>> getAllMessages() async {
    Uri uri =
        Uri.parse('${ApiKey.user}${SharedPrefController().id}/message');
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      return jsonArray.map((e) => AllMessagesModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<MessagesModel?> getMessages({required String id}) async {
    Uri uri =
        Uri.parse('${ApiKey.user}show/$id/${SharedPrefController().id}');
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return MessagesModel.fromJson(jsonResponse);
    }
    return null;
  }

  Future<bool> createMessage(
      {required String itemId,
      required String message,
      required String subject}) async {
    Uri uri = Uri.parse(
        '${ApiKey.user}${SharedPrefController().id}/create-message');
    var response = await http.post(uri, headers: tokenKey, body: {
      'subject': subject,
      'message': message,
      'item': itemId,
    });
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
