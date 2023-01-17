import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rakwa/api/api_helper/api_helper.dart';
import 'package:rakwa/api/api_setting/api_setting.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';

class ReviewApiController with ApiHelper {
  Future<bool> createReview(
      {required String id,
      required dynamic reviewImageGalleries,
      required String rating,
      required String title,
      required String body,
      required String recommend}) async {
    Uri uri = Uri.parse(
        '${ApiKey.createReview}$id/user/${SharedPrefController().id}');
    var requset = http.MultipartRequest('POST', uri);
    requset.headers['Accept'] = 'application/json';
    if (reviewImageGalleries != null) {
      var image = await http.MultipartFile.fromPath(
          'review_image_galleries', reviewImageGalleries);
      requset.files.add(image);
    }

    requset.fields['rating'] = rating;
    requset.fields['customer_service_rating'] = rating;
    requset.fields['quality_rating'] = rating;
    requset.fields['friendly_rating'] = rating;
    requset.fields['pricing_rating'] = rating;
    requset.fields['title'] = title;
    requset.fields['body'] = body;
    requset.fields['recommend'] = recommend;

    var response = await requset.send();

    response.stream.transform(utf8.decoder).listen((value) {});

    if (response.statusCode == 200) {
      return true;
    }
    return false;

    // var response = await http.post(uri, headers: headers,body: {
    //   'rating':
    // });
  }
}
