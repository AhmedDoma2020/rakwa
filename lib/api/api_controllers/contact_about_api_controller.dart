import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rakwa/api/api_helper/api_helper.dart';
import 'package:rakwa/api/api_setting/api_setting.dart';
import 'package:rakwa/model/about_model.dart';
import 'package:rakwa/model/contact_model.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';

class ContactAboutApiController with ApiHelper {
  Future<AboutModel?> getAbout() async {
    Uri uri = Uri.parse(ApiKey.about);
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return AboutModel.fromJson(jsonResponse);
    }
    return null;
  }

  Future<List<ContactModel>> getContact() async {
    Uri uri = Uri.parse(ApiKey.contact);
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      return jsonArray.map((e) => ContactModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<bool> createContact(
      {required String subject, required String message}) async {
    Uri uri = Uri.parse(ApiKey.createContact);
    var response = await http.post(uri, headers: headers, body: {
      'first_name': SharedPrefController().name,
      'last_name': SharedPrefController().name,
      'email': SharedPrefController().email,
      'subject': subject,
      'message': message,
    });
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<AboutModel?> getTermsOfService() async {
    Uri uri = Uri.parse(ApiKey.termsOfService);
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return AboutModel.fromJson(jsonResponse);
    }
    return null;
  }

  Future<AboutModel?> getPrivacyPolicy() async {
    Uri uri = Uri.parse(ApiKey.privacyPolicy);
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return AboutModel.fromJson(jsonResponse);
    }
    return null;
  }
}
