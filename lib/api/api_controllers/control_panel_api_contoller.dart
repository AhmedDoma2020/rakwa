import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rakwa/api/api_helper/api_helper.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';

import '../api_setting/api_setting.dart';

class ControlerPanelApiController with ApiHelper {
  Future<String?> getCountItem() async {
    Uri uri =
        Uri.parse('${ApiKey.user}${SharedPrefController().id}/count-item');
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'];
      return jsonArray.toString();
    }
    return null;
  }

  Future<String?> getCountReview() async {
    Uri uri = Uri.parse(
        '${ApiKey.user}${SharedPrefController().id}/count-reviews');
    var response = await http.get(uri, headers: headers);
    print(response.statusCode);
    print('${ApiKey.user}${SharedPrefController().id}/count-reviews');
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'];
      print(jsonArray);
      return jsonArray.toString();
    }
    return null;
  }

  Future<String?> getCountClssified() async {
    Uri uri = Uri.parse(
        '${ApiKey.user}${SharedPrefController().id}/count-classified');
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'];
      return jsonArray.toString();
    }
    return null;
  }

  Future<String?> getCountMessage() async {
    Uri uri = Uri.parse(
        '${ApiKey.user}${SharedPrefController().id}/count-message');
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'];
      return jsonArray.toString();
    }
    return null;
  }

  Future<String?> getCountComment() async {
    Uri uri = Uri.parse(
        '${ApiKey.user}${SharedPrefController().id}/count-comment');
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'];
      return jsonArray.toString();
    }
    return null;
  }
}
