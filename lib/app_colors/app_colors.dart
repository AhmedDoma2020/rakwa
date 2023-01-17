import 'package:flutter/material.dart';

const double kNRadius = 12;
const double kNButtonRadius = 10;
const double kNCardRadius = 10;

class AppColors {
  // static const mainColor = Color.fromARGB(255, 255, 0, 0);
  static const mainColor = Color(0xFFFF3E16);
  static const subTitleColor = Color(0xFFC1C1C1);
  static const labelColor = Color(0xFFBDBDBD);
  static const bottonNavBarColor = Color(0xFF040404);
  static const drawerColor = Color(0xFF2C2C2C);
  static const blueLightColor = Color(0xFFE8FBFF);
  static const viewAllColor = Color(0xFF747688);
  static const discountColor = Color(0xFFFFF3E8);
  static const rateColor = Color(0xFFF5CE00);
  static const unSelectedTabBar = Color(0xFFA29EB6);
  static const describtionLabel = Color(0xFFA4ACAD);
  static const controlPanelView = Color(0xFFF4F4F4);
  static const backDetails = Color(0xFFD9D9D9);
  static const blue = Color(0xFF3399CC);

  static const scaffoldBackGround = Colors.white;

  //Button Colors
  static const Color disActiveButtonTitle =  Color(0xFFB5B3BFE5);

  // TextField Colors
  static const Color kCTFBackGround = Colors.white;
  static const Color kCTFActiveBackGround = Color(0xFFF5F5F5);
  static const Color kCTFUpperTitle = Color(0xffBBBDC1);
  static const Color kCTFFocusBorder = mainColor;
  static const Color kCTFHintTitle = Color(0xffBBBDC1);
  static const Color kCTFMainTitle = Color(0xff000000);
  static const Color kCTFErrorBorder = Colors.red;
  static const Color kCTFCursor = Color(0xff000000);
  static const Color kCTFPreFixIcon = Color(0xFFFF3E16);
  static const Color kCTFSuffixFixIcon = Color(0xFFFF3E16);
  static const Color kCTFEnableBorder = Color(0xffE6E6E6);
  static const Color kCTFDisableBorder = Color(0xffE6E6E6);
  static const Color kCTFErrorText = Colors.red;
}


class AppBoxShadow {
  static List<BoxShadow> main = [
    BoxShadow(
      color: AppColors.mainColor.withOpacity(0.05),
      offset: const Offset(
        8.0,
        8.0,
      ),
      blurRadius: 10.0,
      spreadRadius: .1,
    ), //BoxShadow
    const BoxShadow(
      color: Colors.white,
      offset: Offset(0.0, 0.0),
      blurRadius: 0.0,
      spreadRadius: 0.0,
    ),
  ];

  static List<BoxShadow> gray = [
    BoxShadow(
      color: Color(0xFF).withOpacity(0.05),
      offset: const Offset(
        8.0,
        8.0,
      ),
      blurRadius: 10.0,
      spreadRadius: .1,
    ), //BoxShadow
    const BoxShadow(
      color: Colors.white,
      offset: Offset(0.0, 0.0),
      blurRadius: 0.0,
      spreadRadius: 0.0,
    ),
  ];

}
