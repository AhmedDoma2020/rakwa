import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:rakwa/app_colors/app_colors.dart';


class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child:
        SpinKitRipple(
          color: AppColors.mainColor,
          size: 70.0.w,
        ),
        // CircularProgressIndicator(backgroundColor: ConstantColor.MAIN_Yellow,),
      ),
    );
  }
}


