import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rakwa/api/api_helper/api_helper.dart';
import 'package:rakwa/api/api_setting/api_setting.dart';
import 'package:rakwa/model/artical_model.dart';

class ArticalApiController with ApiHelper {
  Future<List<ArticalModel>> getArticals() async {
    Uri uri = Uri.parse(ApiKey.artical);
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data'];
      var jsonArrayPost = jsonArray['posts'];
      var jsonArrayPostData = jsonArrayPost['data'] as List;
      return jsonArrayPostData.map((e) => ArticalModel.fromJson(e)).toList();
    }
    return [];
  }
}
