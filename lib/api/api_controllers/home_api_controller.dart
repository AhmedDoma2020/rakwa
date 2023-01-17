import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_helper/api_helper.dart';
import 'package:rakwa/api/api_setting/api_setting.dart';
import 'package:rakwa/model/all_categories_model.dart';
import 'package:rakwa/model/user_login_model.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';

import '../../model/paid_items_model.dart';

class HomeApiController with ApiHelper {
  Future<String?> getBackgroundImage() async {
    Uri uri = Uri.parse(ApiKey.backgroundImage);
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      String jsonArray = jsonResponse['data'];
      print(jsonArray);
      return jsonArray;
    }
    return null;
  }

  Future<UserLoginModel?> emailVerified() async {
    Uri uri = Uri.parse('${ApiKey.verifiedEmail}${SharedPrefController().id}');
    print(uri);
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      // String jsonArray = jsonResponse['data'];
      print(jsonResponse);
      print('++++++========++++++============++++++');
      return UserLoginModel.fromJson(jsonResponse['data']);
    }
    return null;
  }

  Future<List<AllCategoriesModel>> getCategory() async {
    Uri uri = Uri.parse(ApiKey.category);
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['category'] as List;
      return jsonArray
          .where((element) => element['category_parent_id'] == null)
          .map((e) => AllCategoriesModel.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<List<AllCategoriesModel>> getSubCategory({required int id}) async {
    Uri uri = Uri.parse(ApiKey.category);
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['category'] as List;
      return jsonArray
          .where((element) => element['category_parent_id'] == id)
          .map((e) => AllCategoriesModel.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<List<AllCategoriesModel>> getAllCategories() async {
    Uri uri = Uri.parse(ApiKey.allCategories);
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      // var jsonArray = jsonResponse['category'] as List;
      var jsonArray = jsonResponse['data'] as List;
      return jsonArray.map((e) => AllCategoriesModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<AllCategoriesModel>> getAllClassifiedCategories() async {
    Uri uri = Uri.parse(ApiKey.allClassifiedCtegories);
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      return jsonArray.map((e) => AllCategoriesModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<PaidItemsModel>> getPaidItems() async {
    Uri uri = Uri.parse(ApiKey.paidItems);
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      return jsonArray.map((e) => PaidItemsModel.fromJson(e)).toList();
    }
    return [];
  }
  Future<List<PaidItemsModel>> getNearestItems({required int type}) async {
    Uri uri = Uri.parse("${ApiKey.nearestItems}?item_lat=${SharedPrefController().lat}&item_lng=${SharedPrefController().lng}&type=$type");
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      printDM("uri in getNearestItems is ${uri}");
      printDM("response.body in getNearestItems is ${response.body}");
      var jsonResponse = jsonDecode(response.body);
      if(type==0){
        var jsonArray = jsonResponse['nearby_items'] as List;
        return jsonArray.map((e) => PaidItemsModel.fromJson(e)).toList();
      }else{
        var jsonArray = jsonResponse['nearby_items']['data'] as List;
        return jsonArray.map((e) => PaidItemsModel.fromJson(e)).toList();
      }

    }
    return [];
  }

  Future<List<PaidItemsModel>> getPaidClassified() async {
    Uri uri = Uri.parse(ApiKey.paidClassified);
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      return jsonArray.map((e) => PaidItemsModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<PaidItemsModel>> getPopularItems() async {
    Uri uri = Uri.parse(ApiKey.popularItems);
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      return jsonArray.map((e) => PaidItemsModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<PaidItemsModel>> getPopularClassified() async {
    Uri uri = Uri.parse(ApiKey.popularClassified);
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      return jsonArray.map((e) => PaidItemsModel.fromJson(e)).toList();
    }
    return [];
  }
  Future<List<PaidItemsModel>> getNearestClassified({required int type}) async {
    Uri uri = Uri.parse("${ApiKey.nearestClassified}?item_lat=${SharedPrefController().lat}&item_lng=${SharedPrefController().lng}&type=$type");
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      printDM("response.body in getNearestClassified is ${response.body}");
      var jsonResponse = jsonDecode(response.body);
      if(type==0){
        var jsonArray = jsonResponse['nearby_classified'] as List;
        return jsonArray.map((e) => PaidItemsModel.fromJson(e)).toList();
      }else{
        var jsonArray = jsonResponse['nearby_classified']['data'] as List;
        return jsonArray.map((e) => PaidItemsModel.fromJson(e)).toList();
      }
    }
    return [];
  }

  Future<List<PaidItemsModel>> getLatestItems() async {
    Uri uri = Uri.parse(ApiKey.latestItems);
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      return jsonArray.map((e) => PaidItemsModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<PaidItemsModel>> getLatestClassified() async {
    Uri uri = Uri.parse(ApiKey.latestClassified);
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      return jsonArray.map((e) => PaidItemsModel.fromJson(e)).toList();
    }
    return [];
  }
}
