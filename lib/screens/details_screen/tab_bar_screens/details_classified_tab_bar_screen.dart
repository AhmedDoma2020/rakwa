import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:html/parser.dart';
import 'package:rakwa/api/api_controllers/review_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/controller/image_picker_controller.dart';
import 'package:rakwa/model/details_calssified_model.dart';
import 'package:rakwa/screens/details_screen/details_classified_screen.dart';
import 'package:rakwa/screens/details_screen/details_screen.dart';
import 'package:rakwa/screens/details_screen/gallery_screen/gallery_screen.dart';
import 'package:rakwa/screens/messages_screen/create_message.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/widget/main_elevated_button.dart';
import 'package:rakwa/widget/my_text_field.dart';
import 'package:rakwa/widget/rate_stars_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailsClassifiedTabBarScreen extends StatefulWidget {
  final DetailsClassifiedModel detailsModel;
  final Key rateClassifiedKey;

  DetailsClassifiedTabBarScreen(
      {required this.detailsModel, required this.rateClassifiedKey});

  @override
  State<DetailsClassifiedTabBarScreen> createState() =>
      _DetailsClassifiedTabBarScreenState();
}

class _DetailsClassifiedTabBarScreenState
    extends State<DetailsClassifiedTabBarScreen> with Helpers {
  late TextEditingController _reviewTextController;
  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  double finalRating = 3;

  bool showWorkHour = false;
  List<Features> features = [];

  final Set<Marker> _marker = {};

  void _setMarker() {
    setState(() {
      _marker.add(Marker(
          markerId: const MarkerId('value'),
          position: LatLng(
              widget.detailsModel.classified!.itemLat != null
                  ? double.parse(widget.detailsModel.classified!.itemLat!)
                  : 41.0082,
              widget.detailsModel.classified!.itemLng != null
                  ? double.parse(widget.detailsModel.classified!.itemLng!)
                  : 28.9784),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
              title: widget.detailsModel.classified!.state != null
                  ? widget.detailsModel.classified!.state!.stateName
                  : 'İstanbul',
              snippet: widget.detailsModel.classified!.city != null
                  ? widget.detailsModel.classified!.city!.cityName
                  : 'İstanbul')));
    });
  }

  @override
  void initState() {
    super.initState();
    _setMarker();
    _reviewTextController = TextEditingController();
    createFeaturesList();
  }

  @override
  void dispose() {
    _reviewTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // physics: const BouncingScrollPhysics(),
      children: [
        // Text(

        Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'الوصف',
                    style: GoogleFonts.notoKufiArabic(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: SizedBox(
                  width: Get.width,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Text(
                      _parseHtmlString(
                          widget.detailsModel.classified!.itemDescription!),
                      style: GoogleFonts.notoKufiArabic(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.describtionLabel,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        //   'التفاصيل',
        //   style: GoogleFonts.notoKufiArabic(
        //       textStyle: const TextStyle(
        //           fontSize: 16,
        //           fontWeight: FontWeight.w700,
        //           color: Colors.black)),
        // ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
              //   child: Text(
              //     'الوصف',
              //     style: GoogleFonts.notoKufiArabic(
              //         textStyle: const TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.w700,
              //             color: Colors.black)),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Text(
              //     _parseHtmlString(widget.detailsModel.classified!.itemDescription!),
              //     style: GoogleFonts.notoKufiArabic(
              //         textStyle: const TextStyle(
              //             fontSize: 14,
              //             fontWeight: FontWeight.w500,
              //             color: AppColors.describtionLabel)),
              //   ),
              // ),
              SizedBox(
                  height: 290,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: GoogleMap(
                      markers: _marker,
                      mapType: MapType.normal,
                      myLocationEnabled: false,
                      initialCameraPosition: CameraPosition(
                        zoom: 16,
                        target: LatLng(
                            widget.detailsModel.classified!.itemLat != null
                                ? double.parse(
                                    widget.detailsModel.classified!.itemLat!)
                                : 41.0082,
                            widget.detailsModel.classified!.itemLng != null
                                ? double.parse(
                                    widget.detailsModel.classified!.itemLng!)
                                : 28.9784),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.detailsModel.classified!.itemAddress != null
                    ? InkWell(
                        onTap: () {
                          openMap(
                              widget.detailsModel.classified!.itemLat != null
                                  ? double.parse(
                                      widget.detailsModel.classified!.itemLat!)
                                  : 41.0082,
                              widget.detailsModel.classified!.itemLng != null
                                  ? double.parse(
                                      widget.detailsModel.classified!.itemLng!)
                                  : 28.9784);
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            SizedBox(
                              width: Get.width * 0.7,
                              child: Text(
                                widget.detailsModel.classified!.itemAddress!
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.describtionLabel),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Row(
                        children: const [
                          Icon(
                            Icons.location_on_outlined,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            'İstanbul',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.describtionLabel),
                          ),
                        ],
                      ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: MainElevatedButton(
                  height: 56,
                  width: Get.width,
                  borderRadius: 12,
                  onPressed: () {
                    openMap(
                        widget.detailsModel.classified!.itemLat != null
                            ? double.parse(
                                widget.detailsModel.classified!.itemLat!)
                            : 41.0082,
                        widget.detailsModel.classified!.itemLng != null
                            ? double.parse(
                                widget.detailsModel.classified!.itemLng!)
                            : 28.9784);
                  },
                  child: Text(
                    'الاتجاهات',
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              features.isNotEmpty
                  ? const SizedBox(
                      height: 16,
                    )
                  : const SizedBox(),

              features.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Text(
                              'المميزات',
                              style: GoogleFonts.notoKufiArabic(
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black)),
                            ),
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          Container(
                            height: features.length == 1
                                ? 50
                                : features.length == 2
                                    ? 100
                                    : features.length == 3
                                        ? 150
                                        : features.length == 4
                                            ? 200
                                            : features.length == 5
                                                ? 250
                                                : features.length == 6
                                                    ? 300
                                                    : features.length == 7
                                                        ? 350
                                                        : 400,
                            // padding: const EdgeInsets.symmetric(horizontal: 16),
                            color: const Color(0xFFF9F7FA),
                            child: ListView.separated(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: features.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 45,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: features[index]
                                                      .customFieldId ==
                                                  67
                                              ? Text('السعر')
                                              : features[index].customFieldId ==
                                                      104
                                                  ? Text('المعلن')
                                                  : features[index]
                                                              .customFieldId ==
                                                          80
                                                      ? Text('المطلوب')
                                                      : features[index]
                                                                  .customFieldId ==
                                                              105
                                                          ? Text(
                                                              'الطابق (مكان العقار)')
                                                          : features[index]
                                                                      .customFieldId ==
                                                                  107
                                                              ? Text(
                                                                  'نوع الإيجار')
                                                              : features[index]
                                                                          .customFieldId ==
                                                                      112
                                                                  ? Text(
                                                                      'نظام التكييف')
                                                                  : features[index]
                                                                              .customFieldId ==
                                                                          113
                                                                      ? Text(
                                                                          'الأثاث')
                                                                      : features[index].customFieldId ==
                                                                              92
                                                                          ? Text(
                                                                              'الخبرات المطلوبة')
                                                                          : features[index].customFieldId == 95
                                                                              ? Text('الراتب')
                                                                              : features[index].customFieldId == 96
                                                                                  ? Text('مقابلة')
                                                                                  : features[index].customFieldId == 97
                                                                                      ? Text('وظيفة')
                                                                                      : features[index].customFieldId == 98
                                                                                          ? Text('العدد المطلوب')
                                                                                          : Text('مميزات')),
                                      Expanded(
                                          child: Text(
                                        features[index].itemFeatureValue ??
                                            'Features',
                                        overflow: TextOverflow.ellipsis,
                                      ))
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  : SizedBox(),

              // widget.detailsModel.classified!.itemStatus == null &&
              //         widget.detailsModel.classified!.price == null
              //     ? const SizedBox()
              //     : Padding(
              //         // key: detailsClassifiedKey,
              //         padding:
              //             const EdgeInsets.only(left: 16, right: 16, top: 24),
              //         child: Text(
              //           'المميزات',
              //           style: GoogleFonts.notoKufiArabic(
              //               textStyle: const TextStyle(
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.w700,
              //                   color: Colors.black)),
              //         ),
              //       ),
              // widget.detailsModel.classified!.itemStatus != null ||
              //         widget.detailsModel.classified!.price != null
              //     ? const SizedBox(
              //         height: 24,
              //       )
              //     : const SizedBox(),
              // widget.detailsModel.classified!.itemFeaturesString != null
              //     ? Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //         child: Container(
              //           padding: const EdgeInsets.all(12),
              //           color: Color.fromRGBO(245, 243, 247, 0.4),
              //           child: Row(
              //             children: [
              //               Expanded(
              //                 child: Text(
              //                   'السعر',
              //                   style: GoogleFonts.notoKufiArabic(
              //                       textStyle: const TextStyle(
              //                           fontSize: 14,
              //                           fontWeight: FontWeight.w500,
              //                           color: Colors.black)),
              //                 ),
              //               ),
              //               Expanded(
              //                 flex: 2,
              //                 child: Text(
              //                   widget
              //                       .detailsModel.classified!.itemFeaturesString
              //                       .toString(),
              //                   style: GoogleFonts.notoKufiArabic(
              //                       textStyle: const TextStyle(
              //                           fontSize: 14,
              //                           fontWeight: FontWeight.w500,
              //                           color: Colors.black)),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       )
              //     : const SizedBox(),
              // widget.detailsModel.classified!.itemStatus != null
              //     ? Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //         child: Container(
              //           padding: const EdgeInsets.all(12),
              //           color: Color.fromRGBO(245, 243, 247, 0.4),
              //           child: Row(
              //             children: [
              //               Expanded(
              //                 child: Text(
              //                   'الحالة',
              //                   style: GoogleFonts.notoKufiArabic(
              //                       textStyle: const TextStyle(
              //                           fontSize: 14,
              //                           fontWeight: FontWeight.w500,
              //                           color: Colors.black)),
              //                 ),
              //               ),
              //               Expanded(
              //                 flex: 2,
              //                 child: Text(
              //                   widget.detailsModel.classified!.itemStatus
              //                       .toString(),
              //                   style: GoogleFonts.notoKufiArabic(
              //                       textStyle: const TextStyle(
              //                           fontSize: 14,
              //                           fontWeight: FontWeight.w500,
              //                           color: Colors.black)),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       )
              //     : const SizedBox(),
            ],
          ),
        ),
        // const SizedBox(
        //   height: 18,
        // ),

        // Container(
        //   padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        //   decoration: const BoxDecoration(color: Colors.white),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       SizedBox(
        //           height: 193,
        //           child: ClipRRect(
        //             borderRadius: BorderRadius.circular(20),
        //             child: GoogleMap(
        //               markers: _marker,
        //               mapType: MapType.normal,
        //               myLocationEnabled: true,
        //               initialCameraPosition: CameraPosition(
        //                 target: LatLng(
        //                     widget.detailsModel.classified!.itemLat != null
        //                         ? double.parse(
        //                             widget.detailsModel.classified!.itemLat!)
        //                         : 41.0082,
        //                     widget.detailsModel.classified!.itemLng != null
        //                         ? double.parse(
        //                             widget.detailsModel.classified!.itemLng!)
        //                         : 28.9784),
        //               ),
        //             ),
        //           )),
        //       const SizedBox(
        //         height: 12,
        //       ),
        //       widget.detailsModel.classified!.itemAddress != null
        //           ? Text(
        //               widget.detailsModel.classified!.itemAddress!.toString(),
        //               style: GoogleFonts.notoKufiArabic(
        //                   textStyle: const TextStyle(
        //                       fontSize: 12,
        //                       fontWeight: FontWeight.w400,
        //                       color: AppColors.describtionLabel)),
        //             )
        //           : Text(
        //               'İstanbul',
        //               style: GoogleFonts.tajawal(
        //                   textStyle: const TextStyle(
        //                       fontSize: 14,
        //                       fontWeight: FontWeight.w500,
        //                       color: AppColors.describtionLabel)),
        //             ),
        //       const SizedBox(
        //         height: 16,
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 16),
        //         child: MainElevatedButton(
        //           child: Text('الاتجاهات'),
        //           height: 56,
        //           width: Get.width,
        //           borderRadius: 12,
        //           onPressed: () {
        //             openMap(
        //                 widget.detailsModel.classified!.itemLat != null
        //                     ? double.parse(
        //                         widget.detailsModel.classified!.itemLat!)
        //                     : 41.0082,
        //                 widget.detailsModel.classified!.itemLng != null
        //                     ? double.parse(
        //                         widget.detailsModel.classified!.itemLng!)
        //                     : 28.9784);
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        const SizedBox(
          height: 16,
        ),
        widget.detailsModel.classified!.galleries != null &&
                widget.detailsModel.classified!.galleries!.isNotEmpty
            ? Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'الصور والفيديوهات',
                            style: GoogleFonts.notoKufiArabic(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                          ),
                          IconButton(
                              onPressed: () {
                                // Get.to(() => GalleryScreen(
                                //     galleries:
                                //         widget.detailsModel.classified!.galleries!));
                              },
                              icon: const Icon(Icons.arrow_forward_outlined))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    SizedBox(
                      height: 157,
                      child: ListView.separated(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                'https://www.rakwa.com/laravel_project/public/storage/item/gallery/${widget.detailsModel.classified!.galleries![index].itemImageGalleryName}',
                                fit: BoxFit.cover,
                                width: 180,
                                height: 157,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 8,
                            );
                          },
                          itemCount: widget
                              .detailsModel.classified!.galleries!.length),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              )
            : const SizedBox(),

        SizedBox(
          height: 126,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    'المشاركة',
                    style: GoogleFonts.notoKufiArabic(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => CreateMessage(
                            itemId:
                                widget.detailsModel.classified!.id.toString()));
                      },
                      child: Column(
                        children: const [Icon(Icons.message), Text('المسجات')],
                      ),
                    ),
                    const VerticalDivider(
                      color: Color(0xffF4F4F4),
                      thickness: 1,
                    ),
                    InkWell(
                      onTap: () {
                        final data =
                            ClipboardData(text: widget.detailsModel.url);
                        Clipboard.setData(data);
                        Fluttertoast.showToast(
                            msg: "تم نسخ الرابط",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black54,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                      child: Column(
                        children: const [Icon(Icons.copy), Text('نسخ الرابط')],
                      ),
                    ),
                    const VerticalDivider(
                      color: Color(0xffF4F4F4),
                      thickness: 1,
                    ),
                    Column(
                      children: const [Icon(Icons.more_horiz), Text('المزيد')],
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        // Container(
        //   padding: const EdgeInsets.symmetric(vertical: 16),
        //   decoration: const BoxDecoration(color: Colors.white),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Container(
        //         margin: const EdgeInsets.symmetric(horizontal: 16),
        //         child: Column(
        //           children: [
        //             Text(
        //               'اكتب تعليقا',
        //               style: GoogleFonts.notoKufiArabic(
        //                   textStyle: const TextStyle(
        //                       fontSize: 18,
        //                       fontWeight: FontWeight.w700,
        //                       color: Colors.black)),
        //             ),
        //           ],
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 12,
        //       ),
        //       Padding(
        //         // key: addReview,
        //         padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
        //         child: MyTextField(
        //             maxLines: 5,
        //             hintMaxLines: 5,
        //             hint:
        //                 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من ',
        //             controller: _reviewTextController),
        //       ),
        //       const SizedBox(
        //         height: 8,
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 16),
        //         child: RatingBar.builder(
        //           initialRating: finalRating,
        //           minRating: 1,
        //           direction: Axis.horizontal,
        //           allowHalfRating: true,
        //           itemCount: 5,
        //           itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        //           itemBuilder: (context, _) => const Icon(
        //             Icons.star,
        //             color: Colors.amber,
        //           ),
        //           onRatingUpdate: (rating) {
        //             finalRating = rating;
        //           },
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 8,
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 16),
        //         child: SizedBox(
        //           height: 70,
        //           child: Row(
        //             children: [
        //               Expanded(
        //                   // key: addImage,
        //                   child: GetBuilder<ImagePickerController>(
        //                 builder: (controller) {
        //                   return imagePickerController.image_file == null
        //                       ? Container(
        //                           decoration: BoxDecoration(
        //                               borderRadius: BorderRadius.circular(5),
        //                               border: Border.all(
        //                                 color: AppColors.describtionLabel,
        //                               )),
        //                           child: TextButton(
        //                               onPressed: () {
        //                                 imagePickerController
        //                                     .getImageFromGallary();
        //                               },
        //                               child: Row(
        //                                 mainAxisAlignment:
        //                                     MainAxisAlignment.center,
        //                                 children: [
        //                                   Text(
        //                                     'تحميل صورة',
        //                                     style: GoogleFonts.notoKufiArabic(
        //                                         color: Colors.black),
        //                                   ),
        //                                   const SizedBox(
        //                                     width: 5,
        //                                   ),
        //                                   const Icon(
        //                                     Icons.upload,
        //                                     color: Colors.black,
        //                                     size: 20,
        //                                   ),
        //                                 ],
        //                               )),
        //                         )
        //                       : InkWell(
        //                           onTap: () {
        //                             imagePickerController.getImageFromGallary();
        //                           },
        //                           child: Image.file(
        //                             File(
        //                                 imagePickerController.image_file!.path),
        //                             height: 70,
        //                           ),
        //                         );
        //                 },
        //               )),
        //               const SizedBox(
        //                 width: 8,
        //               ),
        //               Expanded(
        //                   child: Container(
        //                 decoration: BoxDecoration(
        //                     color: AppColors.mainColor,
        //                     borderRadius: BorderRadius.circular(5),
        //                     border: Border.all(
        //                       color: AppColors.describtionLabel,
        //                     )),
        //                 child: TextButton(
        //                     onPressed: () {
        //                       createReview(
        //                         id: widget.detailsModel.classified!.id
        //                             .toString(),
        //                         reviewImageGalleries:
        //                             imagePickerController.image_file != null
        //                                 ? imagePickerController.image_file!.path
        //                                 : null,
        //                         rating: finalRating.toString(),
        //                         title: _reviewTextController.text,
        //                         body: _reviewTextController.text,
        //                         recommend: '1',
        //                       );
        //                     },
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       children: [
        //                         Text(
        //                           'ارسال',
        //                           style: GoogleFonts.notoKufiArabic(
        //                               color: Colors.white),
        //                         ),
        //                         const SizedBox(
        //                           width: 5,
        //                         ),
        //                         const Icon(
        //                           Icons.add_circle_outline_sharp,
        //                           color: Colors.white,
        //                           size: 20,
        //                         ),
        //                       ],
        //                     )),
        //               )),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        // const SizedBox(
        //   height: 16,
        // ),

        // Container(
        //   padding: const EdgeInsets.symmetric(vertical: 16),
        //   decoration: const BoxDecoration(color: Colors.white),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Padding(
        //         key: widget.rateClassifiedKey,
        //         padding: const EdgeInsets.only(
        //           right: 16,
        //           left: 16,
        //         ),
        //         child: Text(
        //           'تقييمات',
        //           style: GoogleFonts.notoKufiArabic(
        //               textStyle: const TextStyle(
        //                   fontSize: 18,
        //                   fontWeight: FontWeight.w700,
        //                   color: Colors.black)),
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 12,
        //       ),
        //       widget.detailsModel.reviews!.isNotEmpty
        //           ? SizedBox(
        //               height: 250,
        //               child: ListView.separated(
        //                 padding:
        //                     const EdgeInsets.only(right: 16, left: 16, top: 16),
        //                 separatorBuilder: (context, index) {
        //                   return const Divider(
        //                     color: AppColors.describtionLabel,
        //                   );
        //                 },
        //                 physics: const NeverScrollableScrollPhysics(),
        //                 itemCount: widget.detailsModel.reviews!.length,
        //                 itemBuilder: (context, index) {
        //                   return Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Row(
        //                         mainAxisAlignment:
        //                             MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           Text(
        //                             widget.detailsModel.reviews![index].title!,
        //                             style: GoogleFonts.notoKufiArabic(
        //                                 textStyle: const TextStyle(
        //                               fontSize: 18,
        //                               fontWeight: FontWeight.w700,
        //                             )),
        //                           ),
        //                           const SizedBox(
        //                             width: 24,
        //                           ),
        //                           Row(
        //                             children: [
        //                               Icon(
        //                                 Icons.star,
        //                                 color: widget.detailsModel
        //                                             .reviews![index].rating ==
        //                                         null
        //                                     ? Colors.grey
        //                                     : widget
        //                                                 .detailsModel
        //                                                 .reviews![index]
        //                                                 .rating! >=
        //                                             1
        //                                         ? AppColors.rateColor
        //                                         : Colors.grey,
        //                                 // size: 12,
        //                               ),
        //                               Icon(
        //                                 Icons.star,
        //                                 color: widget.detailsModel
        //                                             .reviews![index].rating ==
        //                                         null
        //                                     ? Colors.grey
        //                                     : widget
        //                                                 .detailsModel
        //                                                 .reviews![index]
        //                                                 .rating! >=
        //                                             2
        //                                         ? AppColors.rateColor
        //                                         : Colors.grey,
        //                                 // size: 12,
        //                               ),
        //                               Icon(
        //                                 Icons.star,
        //                                 color: widget.detailsModel
        //                                             .reviews![index].rating ==
        //                                         null
        //                                     ? Colors.grey
        //                                     : widget
        //                                                 .detailsModel
        //                                                 .reviews![index]
        //                                                 .rating! >=
        //                                             3
        //                                         ? AppColors.rateColor
        //                                         : Colors.grey,
        //                                 // size: 12,
        //                               ),
        //                               Icon(
        //                                 Icons.star,
        //                                 color: widget.detailsModel
        //                                             .reviews![index].rating ==
        //                                         null
        //                                     ? Colors.grey
        //                                     : widget
        //                                                 .detailsModel
        //                                                 .reviews![index]
        //                                                 .rating! >=
        //                                             4
        //                                         ? AppColors.rateColor
        //                                         : Colors.grey,
        //                                 // size: 12,
        //                               ),
        //                               Icon(
        //                                 Icons.star,
        //                                 color: widget.detailsModel
        //                                             .reviews![index].rating ==
        //                                         null
        //                                     ? Colors.grey
        //                                     : widget
        //                                                 .detailsModel
        //                                                 .reviews![index]
        //                                                 .rating! >=
        //                                             5
        //                                         ? AppColors.rateColor
        //                                         : Colors.grey,
        //                                 // size: 12,
        //                               ),
        //                             ],
        //                           ),
        //                         ],
        //                       ),
        //                       const SizedBox(
        //                         height: 24,
        //                       ),
        //                       Container(
        //                         margin:
        //                             const EdgeInsets.symmetric(horizontal: 10),
        //                         child: Text(
        //                           widget.detailsModel.reviews![index].body!,
        //                           style: GoogleFonts.notoKufiArabic(
        //                               textStyle: const TextStyle(
        //                             fontSize: 16,
        //                             fontWeight: FontWeight.w500,
        //                           )),
        //                         ),
        //                       ),
        //                     ],
        //                   );
        //                 },
        //               ))
        //           : Center(
        //               child: Text(
        //                 'لا توجد اي تقييمات',
        //                 style: GoogleFonts.notoKufiArabic(
        //                     textStyle: const TextStyle(
        //                   fontSize: 18,
        //                   fontWeight: FontWeight.w700,
        //                 )),
        //               ),
        //             ),
        //     ],
        //   ),
        // ),
        // const SizedBox(
        //   height: 16,
        // ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 16,
                  left: 16,
                ),
                child: Text(
                  'عناصر القريبة',
                  style: GoogleFonts.notoKufiArabic(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                ),
              ),
              // const SizedBox(
              //   height: 12,
              // ),
              widget.detailsModel.nearbyItems != null &&
                      widget.detailsModel.nearbyItems!.isNotEmpty
                  ? SizedBox(
                      height: widget.detailsModel.nearbyItems!.length >= 3
                          ? 480
                          : widget.detailsModel.nearbyItems!.length >= 2
                              ? 320
                              : 160,
                      child: ListView.separated(
                        padding:
                            const EdgeInsets.only(right: 16, left: 16, top: 16),
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                              height: 32,
                              child: Divider(
                                color: AppColors.describtionLabel,
                              ));
                        },
                        itemCount: widget.detailsModel.nearbyItems!.length >= 3
                            ? 3
                            : widget.detailsModel.nearbyItems!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return DetailsClassifiedScreen(
                                      id: widget.detailsModel
                                          .nearbyItems![index].id!);
                                },
                              ));
                            },
                            child: SizedBox(
                              width: Get.width,
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      'https://www.rakwa.com/laravel_project/public/storage/item/${widget.detailsModel.nearbyItems![index].itemImage}',
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.4,
                                        child: Text(
                                          widget.detailsModel
                                              .nearbyItems![index].itemTitle!,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.notoKufiArabic(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18)),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      RateStarsWidget(
                                          rate: widget
                                                      .detailsModel
                                                      .nearbyItems![index]
                                                      .itemAverageRating ==
                                                  null
                                              ? null
                                              : double.parse(widget
                                                  .detailsModel
                                                  .nearbyItems![index]
                                                  .itemAverageRating
                                                  .toString())),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.6,
                                        child: Text(
                                          _parseHtmlString(widget
                                              .detailsModel
                                              .nearbyItems![index]
                                              .itemDescription
                                              .toString()),
                                          style: GoogleFonts.notoKufiArabic(
                                              textStyle: const TextStyle(
                                                  color: AppColors
                                                      .describtionLabel)),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text(
                        'لا توجد اي عناصر مشابهة',
                        style: GoogleFonts.notoKufiArabic(
                            textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        )),
                      ),
                    ),
            ],
          ),
        ),

        const SizedBox(
          height: 16,
        ),

        widget.detailsModel.classified!.itemSocialFacebook == null &&
                widget.detailsModel.classified!.itemSocialInstagram == null &&
                widget.detailsModel.classified!.itemWebsite == null &&
                widget.detailsModel.classified!.itemSocialTwitter == null
            ? const SizedBox()
            : Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SizedBox(
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          'قم بزيارة مواقع التواصل الاجتماعي الخاص بنا',
                          style: GoogleFonts.notoKufiArabic(
                              textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                          )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                                visible: widget.detailsModel.classified!
                                        .itemSocialFacebook !=
                                    null,
                                child: InkWell(
                                    onTap: () async {
                                      if (await canLaunchUrlString(widget
                                          .detailsModel
                                          .classified!
                                          .itemSocialFacebook!)) {
                                        launchUrlString(
                                            widget.detailsModel.classified!
                                                .itemSocialFacebook!,
                                            mode:
                                                LaunchMode.externalApplication);
                                      }
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Image.asset(
                                            'images/Facebook.png')))),
                            Visibility(
                                visible: widget.detailsModel.classified!
                                        .itemSocialTwitter !=
                                    null,
                                child: InkWell(
                                    onTap: () async {
                                      if (await canLaunchUrlString(widget
                                          .detailsModel
                                          .classified!
                                          .itemSocialTwitter!)) {
                                        launchUrlString(
                                            widget.detailsModel.classified!
                                                .itemSocialTwitter!,
                                            mode:
                                                LaunchMode.externalApplication);
                                      }
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Image.asset(
                                            'images/Twitter.png')))),
                            Visibility(
                                visible: widget.detailsModel.classified!
                                        .itemSocialInstagram !=
                                    null,
                                child: InkWell(
                                    onTap: () async {
                                      if (await canLaunchUrlString(widget
                                          .detailsModel
                                          .classified!
                                          .itemSocialInstagram!)) {
                                        launchUrlString(
                                            widget.detailsModel.classified!
                                                .itemSocialInstagram!,
                                            mode:
                                                LaunchMode.externalApplication);
                                      }
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Image.asset(
                                            'images/Instagram.png')))),
                            Visibility(
                                visible: widget
                                        .detailsModel.classified!.itemWebsite !=
                                    null,
                                child: InkWell(
                                    onTap: () async {
                                      if (await canLaunchUrlString(widget
                                          .detailsModel
                                          .classified!
                                          .itemWebsite!)) {
                                        launchUrlString(
                                            widget.detailsModel.classified!
                                                .itemWebsite!,
                                            mode:
                                                LaunchMode.externalApplication);
                                      }
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Image.asset('images/Link.png'))))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(
        googleUrl,
      );
    } else {
      throw 'Could not open the map.';
    }
  }

  void createFeaturesList() {
    for (int i = 0;
        i <= widget.detailsModel.classified!.features!.length - 1;
        i++) {
      if (widget.detailsModel.classified!.features![i].itemFeatureValue !=
              null &&
          widget.detailsModel.classified!.features![i].itemFeatureValue!
              .isNotEmpty) {
        features.add(widget.detailsModel.classified!.features![i]);
      }
    }
    print(features);
  }

  Future<void> createReview(
      {required String id,
      required var reviewImageGalleries,
      required String rating,
      required String title,
      required String body,
      required String recommend}) async {
    bool status = await ReviewApiController().createReview(
        id: id,
        reviewImageGalleries: reviewImageGalleries,
        rating: rating,
        title: title,
        body: body,
        recommend: recommend);
    if (status) {
      ShowMySnakbar(
          title: 'تمت العملية بنجاح',
          message: 'تم اضافة مراجعتك بنجاح',
          backgroundColor: Colors.green.shade700);
    } else {
      ShowMySnakbar(
          title: 'خطا',
          message: 'حدث خطا ما',
          backgroundColor: Colors.red.shade700);
    }
    imagePickerController.image_file = null;
    _reviewTextController.text = '';
    finalRating = 3;
    setState(() {});
  }
}
