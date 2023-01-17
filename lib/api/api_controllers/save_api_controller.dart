import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rakwa/api/api_helper/api_helper.dart';
import 'package:rakwa/model/all_saved_items_model.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';

import '../api_setting/api_setting.dart';

class SaveApiController with ApiHelper {
  Future<bool> saveItem({required String itemId}) async {
    Uri uri = Uri.parse(
        '${ApiKey.user}${SharedPrefController().id}/save-items/$itemId');
    var response = await http.post(uri, headers: headers);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> unSaveItem({required String itemId}) async {
    Uri uri = Uri.parse(
        '${ApiKey.user}${SharedPrefController().id}/un-save-items/$itemId');
    var response = await http.post(uri, headers: headers);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> saveClassified({required String classifiedId}) async {
    Uri uri = Uri.parse(
        '${ApiKey.user}${SharedPrefController().id}/save-classified/$classifiedId');
    var response = await http.post(uri, headers: headers);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> unSaveClassified({required String classifiedId}) async {
    Uri uri = Uri.parse(
        '${ApiKey.user}${SharedPrefController().id}/un-save-classified/$classifiedId');
    var response = await http.post(uri, headers: headers);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<List<SavedItems>> getSaveItems() async {
    Uri uri = Uri.parse(
        '${ApiKey.user}${SharedPrefController().id}/all-save-item');
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['allsaveitem'] as List;
      var savedItems = jsonArray[0]['saved_items'] as List;

      return savedItems.map((e) => SavedItems.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<SavedItems>> getSaveClassified() async {
    Uri uri = Uri.parse(
        '${ApiKey.user}${SharedPrefController().id}/all-save-classified');
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['allsaveclassified'] as List;
      var savedItems = jsonArray[0]['saved_classified'] as List;

      return savedItems.map((e) => SavedItems.fromJson(e)).toList();
    }
    return [];
  }

  Future<bool> isItemSaved({required int id}) async {
    Uri uri = Uri.parse(
        '${ApiKey.user}${SharedPrefController().id}/all-save-item');
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['allsaveitem'] as List;
      var savedItems = jsonArray[0]['saved_items'] as List;
      savedItems.where((element) {
        if (element['id'] == id) {
          print(element['id']);
          print(id);
          return true;
        }
        return false;
      });
      return false;
      // return savedItems.map((e) => SavedItems.fromJson(e)).toList();
    }
    return false;
  }

  // Future<bool> isItemSaved({required String id}) async {
  //   Uri uri = Uri.parse(
  //       '${ApiSetting.save}${SharedPrefController().id}/all-save-item');
  //   var response = await http.get(uri, headers: headers);
  //   if (response.statusCode == 200) {
  //     var jsonResponse = jsonDecode(response.body);
  //     var jsonArray = jsonResponse['allsaveitem'];
  //     var savedItems = jsonArray[0]['saved_items'] as List;

  //     savedItems.where((element) {
  //       if (element['id'] == id) {
  //         print(element['id']);
  //         return true;
  //       }
  //       return false;
  //     });
  //     return false;
  //   }
  //   return false;
  // }
}
