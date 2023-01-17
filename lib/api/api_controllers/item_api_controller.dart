import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rakwa/api/api_helper/api_helper.dart';
import 'package:rakwa/api/api_setting/api_setting.dart';
import 'package:rakwa/model/item_by_id_model.dart';
import 'package:rakwa/model/item_with_category.dart';
import 'package:rakwa/model/paid_items_model.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';

class ItemApiController with ApiHelper {
  Future<List<ItemWithCategory>> getItemWithCategory(
      {required String id}) async {
    Uri uri = Uri.parse('${ApiKey.itemWithCategory}$id');
    print(uri);
    print('=================================');
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      // if (jsonResponse['all_items'] != null) {
      var jsonArray = jsonResponse['category'] as List;
      return jsonArray.map((e) => ItemWithCategory.fromJson(e)).toList();
      // }
    }

    return [];
  }

  Future<List<ItemByIdModel>> getItemById() async {
    Uri uri = Uri.parse('${ApiKey.user}${SharedPrefController().id}/item');
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      return jsonArray.map((e) => ItemByIdModel.fromJson(e)).toList();
    }

    return [];
  }

  Future<List<PaidItemsModel>> searchItem(
      {required String cityId,
      required String stateId,
      required String category,
      required String classifiedcategories}) async {
    print(category);
    Uri uri = Uri.parse(
        'https://rakwa.com/api/filter?filter_categories[]=$category&filter_state=$stateId&filter_city=$cityId&filter_sort_by=1');
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['free_items']['data'] as List;
      return jsonArray.map((e) => PaidItemsModel.fromJson(e)).toList();
    }
    return [];
  }
}
