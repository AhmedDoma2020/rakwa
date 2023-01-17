import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/widget/rate_stars_widget.dart';

import '../app_colors/app_colors.dart';

class HomeWidget extends StatelessWidget {
  final String title;
  final String location;
  final String? image;
  final String itemType;
  final String discount;
  final dynamic rate;
  final bool doMargin;
  final Widget saveIcon;
  void Function()? onTap;
  void Function()? saveOnPressed;
  final double percentCardWidth;
  final bool isList;

  HomeWidget({
    super.key,
    required this.discount,
    required this.image,
    required this.itemType,
    required this.location,
    required this.title,
    required this.rate,
    this.onTap,
    this.saveOnPressed,
    this.isList = false,
    this.percentCardWidth = 0.8,

    this.saveIcon = const Icon(
      Icons.bookmark_outline_sharp,
      color: Colors.white,
    ),
    this.doMargin = true,
  });

  BorderRadiusGeometry imageBorderRadius = const BorderRadius.only(
      topLeft: Radius.circular(12), topRight: Radius.circular(12));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height:isList? 420:236, //236
            width: Get.width * percentCardWidth,
            decoration: BoxDecoration(
              boxShadow: AppBoxShadow.main,
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Stack(
                  children: [
                    image != null
                        ? ClipRRect(
                            borderRadius: imageBorderRadius,
                            child: Image.network(
                              'https://www.rakwa.com/laravel_project/public/storage/item/$image',
                              fit: BoxFit.cover,
                              width: Get.width,
                            ),
                          )
                        // : Image.network(
                        //     'https://rakwa.com/theme_assets/frontend_assets/lduruo10_dh_frontend_city_path/placeholder/',
                        //     fit: BoxFit.fill,
                        //     width: Get.width,
                        //   ),
                        : ClipRRect(
                            borderRadius: imageBorderRadius,
                            child: Image.asset(
                              'images/logo.png',
                              fit: BoxFit.cover,
                              width: Get.width,
                            ),
                          ),
                    Positioned(
                        left: 13,
                        top: 10,
                        child: CircleAvatar(
                          backgroundColor: Colors.black38.withOpacity(0.5),
                          child: IconButton(
                            onPressed: saveOnPressed,
                            icon: saveIcon,
                            color: Colors.white,
                            // Icons.bookmark_outline_sharp,
                            // Icons.bookmark_outlined,
                            // color: Colors.black,)
                          ),
                        )),
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.15,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                                topLeft: Radius.circular(12)),
                            color: Color(0xFF000000),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 200,
                            child: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.notoKufiArabic(
                                  textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),
                            ),
                          ),
                          rate != '100'
                              ? Row(
                                  children: [
                                    Text(
                                      rate ?? '0',
                                      style: GoogleFonts.notoKufiArabic(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    DisplayRateWidget(
                                        size: 18,
                                        isRated: rate == null
                                            ? false
                                            : double.parse(rate!) >= 1
                                                ? true
                                                : false)
                                  ],
                                )
                              : SizedBox()
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: AppColors.mainColor,
                          ),
                          8.ESW(),
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: Get.width * .75,
                            ),
                            child: Text(
                              location,
                              style: GoogleFonts.tajawal(
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.viewAllColor,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              maxLines: 2,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          // Container(
                          //   padding: const EdgeInsets.symmetric(
                          //       horizontal: 3, vertical: 1),
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(50),
                          //       color: AppColors.discountColor),
                          //   child: Text(
                          //     'خصم $discount %',
                          //     style: GoogleFonts.notoKufiArabic(
                          //         textStyle: const TextStyle(
                          //       fontSize: 10,
                          //       fontWeight: FontWeight.w500,
                          //     )),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   width: 8,
                          // ),
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: Get.width * .8,
                            ),
                            // width:100,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.blueLightColor,
                            ),
                            child: Text(
                              itemType,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.tajawal(
                                  textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              )),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
