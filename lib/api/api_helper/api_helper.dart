
import 'dart:io';

import '../../shared_preferences/shared_preferences.dart';

mixin ApiHelper {
  // ApiResponse get failedResponse =>
  //     ApiResponse(message: 'Something went wrong', success: false);

  Map<String, String> get headers {
    return {
      HttpHeaders.acceptHeader: 'application/json',
    };
  }

  
  Map<String, String> get tokenKey {
    return {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
       HttpHeaders.acceptHeader: 'application/json',
    };
  }


}