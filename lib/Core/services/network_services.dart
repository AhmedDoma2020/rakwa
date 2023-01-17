import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_setting/api_setting.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';

class NetworkService with ApiKey {
  Dio dio = Dio();

  Future<Response> get(
      {@required String? url,
      Map<String, String>? headers,
      bool auth = false}) async {
    Response? response;
    String apiToken = SharedPrefController().token;
    String staticApiToken =
        "\$2y\$10\$DRe4b95AAM9WFq.qa4KG7eS5PgjSiW5pJC3tTqM5OoW7ktZNIDN6u";
    log("apiToken storage in netWork >>>>>>>>>:-> $apiToken");
    log("apiToken static in netWork >>>>>>>>>:-> $staticApiToken");
    try {
      dio.options.baseUrl = ApiKey.baseUrl;
      response = await dio.get(
        url!,
        options: Options(
          headers: headers ??
              {
                // 'Accept-Language': '${box.read("lan") ?? 'ar'}',
                'Accept-Language': 'ar',
                "Accept":'application/json',

                if (auth)
                  'Authorization': 'Bearer ${SharedPrefController().token}'
                // 'Authorization': 'Bearer ' + staticApiToken
              },
        ),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
      }
    } on SocketException {
      throw SocketException;
    } catch (e) {
      throw SocketException;
    }
    return handleResponse(response!);
  }

  Future<Response> post({
    @required String? url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool auth = false,
    List<File>? fileList,
    bool isForm = false,
    String fileKey = '',
    String fileName = '',
    ResponseType? responseType,
  }) async {
    FormData formData = FormData.fromMap(
      body ?? {},
    );
    /*** handle upload images ***/
    if (fileList != null) {
      for (File item in fileList) {
        formData.files.add(
          MapEntry(
            fileKey,
            await MultipartFile.fromFile(
              item.path,
              filename: fileName,
            ),
          ),
        );
      }
    }
    Response? response;
    String apiToken = SharedPrefController().token;
    // services
    // String staticApiToken = "\$2y\$10\$y4chJBLfnOw2IOjURr2spea5Ge1MMZulc9OF1sXQ9IBCsW3S158t.";
    //patient
    String staticApiToken =
        "\$2y\$10\$DRe4b95AAM9WFq.qa4KG7eS5PgjSiW5pJC3tTqM5OoW7ktZNIDN6u";

    log("apiToken storage in netWork >>>>>>>>>:-> $apiToken");
    log("apiToken static in netWork >>>>>>>>>:-> $staticApiToken");
    dio.options.baseUrl = ApiKey.baseUrl;
    try {
      response = await dio.post(
        url!,
        data: isForm ? formData : body,
        options: Options(
          responseType: responseType,
          headers: headers ??
              {
                // 'Accept-Language': '${box.read("lan") ?? 'ar'}',
                'Accept-Language': 'ar',
                "Accept":'application/json',
                if (auth)
                  'Authorization':
                      'Bearer ${SharedPrefController().token}' // 'Authorization': 'Bearer ' + staticApiToken
              },
          // requestEncoder: encoding,
        ),
      );
      printDM("url in network is $url");
      printDM("body in network is  $body");
    } on DioError catch (e) {
      printDM("error url in network is $url");
      printDM("error body in network is  $body");
      if (e.response != null) {
        response = e.response;
      }
    }
    return handleResponse(response!);
  }

  Response handleResponse(Response response) {
    final int statusCode = response.statusCode ?? 500;
    if (statusCode >= 200 && statusCode < 300) {
      printDM("correct request: " + response.toString());
      return response;
    } else {
      printDM("correct request: " + response.toString());
      return response;
    }
  }
}
