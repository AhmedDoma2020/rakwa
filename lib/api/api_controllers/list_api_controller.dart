import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_helper/api_helper.dart';
import 'package:rakwa/api/api_setting/api_setting.dart';
import 'package:rakwa/model/all_categories_model.dart';
import 'package:rakwa/model/autocomplete_model.dart';
import 'package:rakwa/model/city_model.dart';
import 'package:rakwa/model/country_model.dart';
import 'package:rakwa/model/create_item_model.dart';
import 'package:rakwa/model/custom_field_model.dart';
import 'package:rakwa/model/paid_items_model.dart';

class ListApiController with ApiHelper {
  Future<List<CountryModel>> getCountrys() async {
    Uri uri = Uri.parse(ApiKey.country);
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['country'] as List;
      return jsonArray.map((e) => CountryModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<CityModel>> getCitys({required String id}) async {
    Uri uri = Uri.parse('${ApiKey.city}/$id');
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['city'] as List;
      return jsonArray.map((e) => CityModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<StateModel>> getState({required String id}) async {
    Uri uri = Uri.parse('${ApiKey.state}/$id');
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['state'] as List;
      return jsonArray.map((e) => StateModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<CustomFieldModel?> getCustomFields(
      {required List<int> ids, required bool isList}) async {
    Map<String, String> data = {};
    for (int i = 0; i < ids.length; i++) {
      data.addAll({'category[$i]' : ids[i].toString()});
    }
    printDM("categoryIds body send is => $data ");
    Uri uri;
    if (isList) {
      uri = Uri.parse(ApiKey.customFields);
    } else {
      uri = Uri.parse(ApiKey.customClassifiedFields);
    }
    var response = await http.post(uri, headers: headers, body: data);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return CustomFieldModel.fromJson(jsonResponse);
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

  Future<List<AllCategoriesModel>> getClassifiedCategory() async {
    Uri uri = Uri.parse(ApiKey.classifiedCategory);
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['classified_category'] as List;
      return jsonArray
          .where((element) => element['category_parent_id'] == null)
          .map((e) => AllCategoriesModel.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<List<AllCategoriesModel>> getClassifiedSubCategory(
      {required int id}) async {
    Uri uri = Uri.parse(ApiKey.classifiedCategory);
    var response = await http.get(uri, headers: tokenKey);
    printDM("response getClassifiedSubCategory is => ${response.body}");
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['classified_category'] as List;
      return jsonArray
          .where((element) => element['category_parent_id'] == id)
          .map((e) => AllCategoriesModel.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<List<AutoCompleteModel>> getAddress({required String input}) async {
    Uri uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=AIzaSyBauBUw7ABmSkqpsx0yLM73Eqehz1guZS0');
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['predictions'] as List;
      return jsonArray.map((e) => AutoCompleteModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<Map<String, double>> getAddressDetails({required String id}) async {
    Uri uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$id&key=AIzaSyBauBUw7ABmSkqpsx0yLM73Eqehz1guZS0');
    var response = await http.get(uri, headers: tokenKey);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['result'];
      var result = jsonArray['geometry'];
      var geometry = result['location'];
      Map<String, double> location = {
        'lat': geometry['lat'],
        'lng': geometry['lng'],
      };
      return location;
    }
    return {};
  }

  String generateSlug(String input) {
    return input.replaceAll(RegExp(r'[^a-zA-Z0-9]+'), '-').toLowerCase();
  }
  Future<bool> addList({
    required CreateItemModel createItemModel,
    required bool isList,
    required List checkBox,
    required List textFiled,
    List? customFileds,
  }) async {
    print(createItemModel.category);
    List myField = [];
    Uri uri;
    if (isList) {
      uri = Uri.parse('${ApiKey.addList}211/create-item');
    } else {
      uri = Uri.parse('${ApiKey.addList}211/create-classified');
    }

    if (customFileds != null && customFileds.isNotEmpty) {
      for (int i = 0; i <= customFileds.length - 1; i++) {
        var aString = customFileds[i].replaceAll(RegExp(r'[^0-9]'), '');
        var aInteger = int.parse(aString);
        myField.add(aInteger);
      }
    }

    print(uri);
    print(createItemModel);

    var requset = http.MultipartRequest('POST', uri);
    requset.headers['Accept'] = 'application/json';
    var featureImage = await http.MultipartFile.fromPath(
        'feature_image', createItemModel.featureImage!);

    if (createItemModel.imageGallery != null &&
        createItemModel.imageGallery!.isNotEmpty) {
      var imageGallery;

      for (int i = 0; i < createItemModel.imageGallery!.length; i++) {
        imageGallery = await http.MultipartFile.fromPath(
            'image_gallery[$i]', createItemModel.imageGallery![i].toString());
        requset.files.add(imageGallery);
      }
    }

    if (checkBox.isNotEmpty) {
      for (int i = 0; i <= checkBox.length - 1; i++) {
        for (int t = 0; t <= myField.length - 1; t++) {
          if (checkBox[i][1] == myField[t]) {
            for (int o = 0;
            o <= {checkBox[i][1] == myField[t]}.length - 1;
            o++) {
              requset.fields['${customFileds![t]}[$o]'] = checkBox[i][0];
              print('${customFileds[t]}[$o]=>${checkBox[i][0]}');
            }

            // requset.fields['${checkBox[i][2]}${checkBox[1]}'] =
            //     checkBox[i][0].toString();
          }
        }
      }
    }

    if (textFiled.isNotEmpty) {
      for (int i = 0; i <= textFiled.length - 1; i++) {
        for (int t = 0; t <= myField.length - 1; t++) {
          if (textFiled[i][1] == myField[t]) {
            requset.fields['${customFileds![t]}'] = textFiled[i][0].toString();
            print('${customFileds[t]}=${textFiled[i][0]}');
          }
        }

        // requset.fields['${textFiled[i][2]}${textFiled[1]}'] =
        //     textFiled[i][0].toString();
        // print('${textFiled[i][2]}${textFiled[i][1]}== ${textFiled[i][0]}');
      }
    }

    requset.files.add(featureImage);
    requset.fields['item_type'] = createItemModel.itemType.toString();
    requset.fields['item_featured'] = createItemModel.itemFeatured.toString();

    requset.fields['item_title'] = createItemModel.itemTitle!;
    requset.fields['city_id'] = createItemModel.cityId!;
    if (createItemModel.itemAddress != null && createItemModel.itemAddress!.isNotEmpty) {
      requset.fields['item_address'] = createItemModel.itemAddress.toString();
    }
    requset.fields['state_id'] = createItemModel.stateId.toString();
    requset.fields['country_id'] = createItemModel.countryId.toString();
    requset.fields['item_postal_code'] =
        createItemModel.itemPostalCode.toString();
    for (int i = 0; i < createItemModel.category.length; i++) {
      requset.fields['category[$i]'] = createItemModel.category[i].toString();
    }

    if (createItemModel.itemHours.isNotEmpty) {
      for (int i = 0; i < createItemModel.itemHours.length; i++) {
        requset.fields['item_hours[$i]'] =
            createItemModel.itemHours[i].toString();
      }
    }

    if (createItemModel.price != null) {
      requset.fields['price'] = createItemModel.price!;
    }

    if (createItemModel.itemDescription != null) {
      requset.fields['item_description'] = createItemModel.itemDescription!;
    }
    if (createItemModel.itemLat != null && createItemModel.itemLng != null) {
      requset.fields['item_lat'] = createItemModel.itemLat!.toString();
      requset.fields['item_lng'] = createItemModel.itemLng!.toString();
    }

    if (createItemModel.itemWebsite != null) {
      requset.fields['item_website'] = createItemModel.itemWebsite!;
    }
    if (createItemModel.itemPhone != null) {
      requset.fields['item_phone'] = createItemModel.itemPhone!;
    }
    if (createItemModel.itemSocialFacebook != null) {
      requset.fields['item_social_facebook'] =
      createItemModel.itemSocialFacebook!;
    }
    if (createItemModel.itemSocialTwitter != null) {
      requset.fields['item_social_twitter'] =
      createItemModel.itemSocialTwitter!;
    }
    if (createItemModel.itemSocialLinkedin != null) {
      requset.fields['item_social_linkedin'] =
      createItemModel.itemSocialLinkedin!;
    }
    if (createItemModel.itemYoutubeId != null) {
      requset.fields['item_youtube_id'] = createItemModel.itemYoutubeId!;
    }
    if (createItemModel.itemHourTimeZone != null) {
      requset.fields['item_hour_time_zone'] = createItemModel.itemHourTimeZone!;
    }
    if (createItemModel.itemHourShowHours != null) {
      requset.fields['item_hour_show_hours'] =
          createItemModel.itemHourShowHours!.toString();
    }
    if (createItemModel.itemSocialWhatsapp != null) {
      requset.fields['item_social_whatsapp'] =
      createItemModel.itemSocialWhatsapp!;
    }
    if (createItemModel.itemSocialInstagram != null) {
      requset.fields['item_social_instagram'] =
      createItemModel.itemSocialInstagram!;
    }

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
