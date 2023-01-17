import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rakwa/api/api_helper/api_helper.dart';
import 'package:rakwa/api/api_setting/api_setting.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';

class ClaimsApiController with ApiHelper {
  Future<bool> createClaims({
    required var image,
    required String id,
    required String name,
    required String phone,
    required String email,
    required String proof,
  }) async {
    Uri uri =
        Uri.parse('${ApiKey.user}${SharedPrefController().id}/item-claims');
    var requset = http.MultipartRequest('POST', uri);
    requset.headers['Accept'] = 'application/json';
    var itemClaimAdditionalUpload = await http.MultipartFile.fromPath(
        'item_claim_additional_upload', image);
    requset.files.add(itemClaimAdditionalUpload);
    requset.fields['item_claims_item_id'] = id;
    requset.fields['item_claim_full_name'] = name;
    requset.fields['item_claim_phone'] = phone;
    requset.fields['item_claim_email'] = email;
    requset.fields['item_claim_additional_proof'] = proof;

    var response = await requset.send();
    print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value) {
          print(value);

    });

    if (response.statusCode == 200) {
      return true;
    }
    print(response.statusCode);
    return false;
  }
}
