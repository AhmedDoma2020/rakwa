import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rakwa/api/api_helper/api_helper.dart';
import 'package:rakwa/api/api_setting/api_setting.dart';
import 'package:rakwa/model/paid_items_model.dart';
import 'package:rakwa/model/search_model.dart';

class SearchApiController with ApiHelper {
  Future<List<PaidItemsModel>> search(
      {String? searchQuery,
      required String cityId,
      required String stateId,
      required String category,
      required String classifiedcategories,
      required bool isItem}) async {
    Uri uri;

    uri = Uri.parse(
        'https://rakwa.com/api/search?search_query=$searchQuery&filter_state=$stateId&filter_city=$cityId&filter_sort_by=1&filter_categories%5B%5D=$category&filter_classifiedcategories%5B%5D=$classifiedcategories');


    print(uri);
    print('==============================================');
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      List jsonArray;
      if (isItem) {
        jsonArray = jsonResponse['free_items'] as List;
      } else {
        jsonArray = jsonResponse['free_classified'] as List;
      }


      return jsonArray.map((e) => PaidItemsModel.fromJson(e)).toList();
    }
    return [];
  }
}
