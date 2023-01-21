import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_helper/api_helper.dart';
import 'package:rakwa/api/api_setting/api_setting.dart';
import 'package:rakwa/model/classified_by_id_model.dart';
import 'package:rakwa/model/classified_with_category.dart';
import 'package:rakwa/model/item_with_category.dart';
import 'package:rakwa/model/paid_items_model.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';

class ClassifiedApiController with ApiHelper {
  Future<List<ClassifiedByIdModel>> getClassifiedById() async {
    Uri uri = Uri.parse(
        '${ApiKey.classifiedById}${SharedPrefController().id}/classified');
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'] as List;
      return jsonArray.map((e) => ClassifiedByIdModel.fromJson(e)).toList();
    }

    return [];
  }

   Future<List<ClassifiedWithCategory>> getClassifedWithCategory(
      {required String id}) async {
    printDM("classified-categorys is => $id");
    Uri uri = Uri.parse('${ApiKey.classifiedWithCategory}$id');
    var response;
    try{
     response = await http.get(uri, headers: tokenKey);
    }catch(e){
      printDM("e is => $e");
    }
    if (response.statusCode == 200) {
      printDM("response classified-categorys is => ${response.body}");

      var jsonResponse = jsonDecode(response.body);

      // if (jsonResponse['all_items'] != null) {
        var jsonArray = jsonResponse['classified_category'] as List;
      printDM("jsonArray classified-categorys is => ${jsonArray.length}");

      return jsonArray.map((e) => ClassifiedWithCategory.fromJson(e)).toList();
      // }
    }

    return [];
  }


   Future<List<PaidItemsModel>> searchClassified(
      {required String cityId,
      required String stateId,
      required String category,
      required String classifiedcategories}) async {
        print(category);
    Uri uri = Uri.parse(
        'https://rakwa.com/api/filter/classified?filter_categories[]=$category&filter_state=$stateId&filter_city=$cityId&filter_sort_by=1&paginate=200');
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['free_classified']['data'] as List;
      return jsonArray.map((e) => PaidItemsModel.fromJson(e)).toList();
    }
    return [];
  }
}
