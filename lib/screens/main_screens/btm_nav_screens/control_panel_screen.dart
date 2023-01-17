import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/api/api_controllers/control_panel_api_contoller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_classified_category_screen.dart';
import 'package:rakwa/screens/control_panel_screens/my_ads_screen.dart';
import 'package:rakwa/screens/messages_screen/messages_screen.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/control_panel_widget.dart';

import '../../save_screen/save_screen.dart';

class ControlPanelScreen extends StatefulWidget {
  const ControlPanelScreen({super.key});

  @override
  State<ControlPanelScreen> createState() => _ControlPanelScreenState();
}

class _ControlPanelScreenState extends State<ControlPanelScreen> {
  List controlPanel = [
    [Icons.list, 'قائمتي'],
    [Icons.email_outlined, 'الرسائل'],
    [Icons.bookmark_outline_sharp, 'المحفوظات'],
    [Icons.star_border, 'التقييمات'],
    [Icons.class_outlined, 'اعلانات مبوبة'],
    [Icons.class_, 'اضف اعلان'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarDefault(title: "الأنشطة"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الاحصائيات',
                  style: GoogleFonts.notoKufiArabic(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Expanded(
                        child: FutureBuilder<String?>(
                      future: ControlerPanelApiController().getCountItem(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ControlPanelWidget(
                            count: '0',
                            title: 'القائمة',
                            iconURL: "list",
                            color: const Color(0xFFFF8424),
                          );
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          return ControlPanelWidget(
                            count: snapshot.data!,
                            title: 'القائمة',
                            iconURL: "list",
                            color: const Color(0xFFFF8424),
                          );
                        } else {
                          return ControlPanelWidget(
                            count: '0',
                            title: 'القائمة',
                            iconURL: "list",
                            color: const Color(0xFFFF8424),
                          );
                        }
                      },
                    )),
                    const SizedBox(width: 16),
                    Expanded(
                        child: FutureBuilder<String?>(
                      future: ControlerPanelApiController().getCountComment(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ControlPanelWidget(
                            count: '0',
                            title: 'التعليقات',
                            iconURL: "commint",
                            color: const Color(0xFFFF3E16),
                          );
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          return ControlPanelWidget(
                            count: snapshot.data!,
                            title: 'التعليقات',
                            iconURL: "commint",
                            color: const Color(0xFFFF3E16),
                          );
                        } else {
                          return ControlPanelWidget(
                            count: '0',
                            title: 'التعليقات',
                            iconURL: "commint",
                            color: const Color(0xFFFF3E16),
                          );
                        }
                      },
                    )),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                      child: FutureBuilder<String?>(
                        future: ControlerPanelApiController().getCountMessage(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return ControlPanelWidget(
                              count: '0',
                              title: 'الرسائل',
                              iconURL: "message",
                              color: const Color(0xFF02ADF2),
                            );
                          } else if (snapshot.hasData &&
                              snapshot.data!.isNotEmpty) {
                            return ControlPanelWidget(
                              count: snapshot.data!,
                              title: 'الرسائل',
                              iconURL: "message",
                              color: const Color(0xFF02ADF2),
                            );
                          } else {
                            return ControlPanelWidget(
                              count: '0',
                              title: 'الرسائل',
                              iconURL: "message",
                              color: const Color(0xFF02ADF2),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                        child: FutureBuilder<String?>(
                      future: ControlerPanelApiController().getCountReview(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ControlPanelWidget(
                            count: '0',
                            title: 'المشاهدات',
                            iconURL: "viwer",
                            color: const Color(0xFFF9C104),
                          );
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          return ControlPanelWidget(
                            count: snapshot.data!,
                            title: 'المشاهدات',
                            iconURL: "viwer",
                            color: const Color(0xFFF9C104),
                          );
                        } else {
                          return ControlPanelWidget(
                            count: '0',
                            title: 'المشاهدات',
                            iconURL: "viwer",
                            color: const Color(0xFFF9C104),
                          );
                        }
                      },
                    )),
                  ],
                ),
              ],
            )),
            // Expanded(
            //     child: Center(
            //   child: GridView.builder(
            //     physics: const BouncingScrollPhysics(),
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 3,
            //         mainAxisSpacing: 15,
            //         crossAxisSpacing: 5),
            //     itemCount: controlPanel.length,
            //     itemBuilder: (context, index) {
            //       return InkWell(
            //         onTap: () {
            //           if (index == 0) {
            //           } else if (index == 1) {
            //             Get.to(() => const MessagesScreen());
            //           } else if (index == 2) {
            //             Get.to(() => const SaveScreen());
            //           } else if (index == 4) {
            //             // Get.to(() => const MyAdsScreen());
            //           } else if (index == 5) {
            //             Get.to(() => const AddListClassifiedCategoryScreen());
            //           }
            //         },
            //         child: Container(
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(12),
            //               border: Border.all(
            //                 color: AppColors.labelColor,
            //               )),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Icon(
            //                 controlPanel[index][0],
            //                 color: AppColors.mainColor,
            //               ),
            //               const SizedBox(
            //                 height: 12,
            //               ),
            //               Text(
            //                 controlPanel[index][1],
            //                 style: GoogleFonts.notoKufiArabic(
            //                     textStyle: const TextStyle(
            //                         fontSize: 14,
            //                         fontWeight: FontWeight.bold,
            //                         color: Colors.black)),
            //               ),
            //               const SizedBox(
            //                 height: 12,
            //               ),
            //               Container(
            //                 padding: const EdgeInsets.symmetric(vertical: 5),
            //                 margin: const EdgeInsets.symmetric(horizontal: 5),
            //                 decoration: BoxDecoration(
            //                     color: AppColors.controlPanelView,
            //                     borderRadius: BorderRadius.circular(11)),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                   children: [
            //                     Text('رؤية',
            //                         style: GoogleFonts.notoKufiArabic(
            //                             textStyle: const TextStyle(
            //                                 fontSize: 12,
            //                                 fontWeight: FontWeight.bold,
            //                                 color: Colors.black))),
            //                     const Icon(
            //                       Icons.arrow_forward_ios,
            //                       size: 18,
            //                     )
            //                   ],
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ))
          ],
        ),
      ),
    );
  }
}