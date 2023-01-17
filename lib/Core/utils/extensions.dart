import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



extension ScreenSpaces on num {
  // ignore: non_constant_identifier_names
  SizedBox ESW() {
    return SizedBox(width: this.w,);
  }
  // ignore: non_constant_identifier_names
  SizedBox ESH() {
    return SizedBox(height: this.h,);
  }
}


extension AssetUrl on String {
  // ignore: non_constant_identifier_names
  String asset() {
    return 'assets/icons/${this}';
  }
}

void printDM(String title) {
  if(kDebugMode)log(title);
}
