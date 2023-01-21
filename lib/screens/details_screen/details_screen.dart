import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rakwa/Core/utils/dynamic_link_service.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_controllers/details_api_controller.dart';
import 'package:rakwa/api/api_controllers/save_api_controller.dart';
import 'package:rakwa/controller/image_picker_controller.dart';
import 'package:rakwa/controller/show_title_getx_controller.dart';
import 'package:rakwa/model/details_model.dart';
import 'package:rakwa/model/paid_items_model.dart';
import 'package:rakwa/screens/claims_screens/create_claims_screen.dart';
import 'package:rakwa/screens/details_screen/Widgets/top_details_screen_widget.dart';
import 'package:rakwa/screens/details_screen/gallery_screen/gallery_screen.dart';
import 'package:rakwa/screens/details_screen/tab_bar_screens/details_tab_bar_screen.dart';
import 'package:rakwa/screens/details_screen/tab_bar_screens/images_tab_bar_screen.dart';
import 'package:rakwa/screens/details_screen/tab_bar_screens/location_tab_bar_screen.dart';
import 'package:rakwa/screens/details_screen/tab_bar_screens/rate_tab_bar_screen.dart';
import 'package:rakwa/screens/messages_screen/create_message.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/widget/rate_stars_widget.dart';
import 'package:rakwa/widget/share_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../app_colors/app_colors.dart';

class DetailsScreen extends StatefulWidget {
  final String id;

  DetailsScreen({required this.id});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin, Helpers {
  ScrollController scrollController = ScrollController();
  CarouselController buttonCarouselController = CarouselController();

  ShowTitleGetxController showTitleGetxController =
      Get.put(ShowTitleGetxController());
  final rateKey = new GlobalKey();
  final detailsKey = new GlobalKey();
  final addReview = new GlobalKey();
  final addImage = new GlobalKey();
  FocusNode focusNode = FocusNode();
  bool silverCollapsed = false;
  bool show = false;

  late TabController _tabController;
  bool showWorkHour = false;
  final Set<Marker> _marker = {};

  void _setMarker({required var detailsModel}) {
    _marker.add(
      Marker(
        markerId: const MarkerId('value'),
        position: LatLng(
            detailsModel.item!.itemLat != null
                ? double.parse(detailsModel.item!.itemLat!)
                : 41.0082,
            detailsModel.item!.itemLng != null
                ? double.parse(detailsModel.item!.itemLng!)
                : 28.9784),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: detailsModel.item!.state != null
              ? detailsModel.item!.state!.stateName
              : 'İstanbul',
          snippet: detailsModel.item!.city != null
              ? detailsModel.item!.city!.cityName
              : 'İstanbul',
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        // appBar: AppBar(
        //   title: GetBuilder<ShowTitleGetxController>(
        //     builder: (controller) {
        //       return Text('${showTitleGetxController.show}');
        //     },
        //   ),
        // ),
        body: SafeArea(
          bottom: false,
          child: FutureBuilder<DetailsModel?>(
            future: DetailsApiController().getDetails(id: widget.id.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ));
              } else if (snapshot.hasData) {
                scrollController.addListener(() {
                  if (scrollController.offset > 254) {
                    showTitleGetxController.showTitle(newShow: true);
                  } else {
                    showTitleGetxController.showTitle(newShow: false);
                  }
                });
                return CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 254,
                      pinned: true,
                      stretch: true,
                      backgroundColor: Colors.black12,
                      leadingWidth: 80,
                      leading: LeadingSliverAppBarIconDetailsScreen(),
                      actions: [
                        SaveItemWidget(id: snapshot.data!.item!.id.toString()),
                        ShareItemWidget(id: snapshot.data!.item!.id.toString(),kayType: "category"),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        title: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              // color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            snapshot.data!.item!.itemTitle!,
                            style: GoogleFonts.notoKufiArabic(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        titlePadding: EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 40,
                        ),
                        background: SizedBox(
                          height: 254,
                          width: Get.width,
                          child: Stack(
                            children: [
                              TopDetailsScreenWidget(snapshot: snapshot),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          AnimationLimiter(
                            child: Column(
                              children: AnimationConfiguration.toStaggeredList(
                                duration: const Duration(milliseconds: 375),
                                childAnimationBuilder: (widget) =>
                                    SlideAnimation(
                                  horizontalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: widget,
                                  ),
                                ),
                                children: [
                                  Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 16),
                                      child: SizedBox(
                                        height: 35,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount: snapshot.data!.item!
                                              .allCategories!.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6,
                                                      horizontal: 12),
                                              margin: const EdgeInsets.only(
                                                  left: 5),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.blueAccent,
                                                gradient:
                                                    AppColors.mainGradient,
                                              ),
                                              child: Text(
                                                snapshot
                                                    .data!
                                                    .item!
                                                    .allCategories![index]
                                                    .categoryName!,
                                                style:
                                                    GoogleFonts.notoKufiArabic(
                                                  // ignore: prefer_const_constructors
                                                  textStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )),
                                  Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 16),
                                      child: Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: TextButton(
                                            style: ButtonStyle(
                                                fixedSize:
                                                    MaterialStateProperty.all(
                                                        Size(Get.width, 40))),
                                            onPressed: () {
                                              if (SharedPrefController()
                                                      .roleId ==
                                                  3) {
                                                if (SharedPrefController()
                                                        .verifiedEmail !=
                                                    'null') {
                                                  Get.to(() =>
                                                      CreateClaimsScreen(
                                                          id: snapshot
                                                              .data!.item!.id
                                                              .toString()));
                                                } else {
                                                  ShowMySnakbar(
                                                      title:
                                                          'لم تقم بتاكيد حسابك',
                                                      message:
                                                          'يجب عليك تاكيد حسابك قبل',
                                                      backgroundColor:
                                                          Colors.red.shade700);
                                                }
                                              } else if (SharedPrefController()
                                                      .roleId ==
                                                  2) {
                                                alertDialogRoleAuthUser(
                                                    context);
                                              } else {
                                                AlertDialogUnAuthUser(context);
                                              }
                                            },
                                            child: Text(
                                              'المطالبة بإدارة العمل',
                                              style: GoogleFonts.notoKufiArabic(
                                                textStyle: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        DetailsButton(
                                          iconData:
                                              Icons.messenger_outline_rounded,
                                          name: 'رسالة',
                                          onTap: () {
                                            print(snapshot.data!.item!.id
                                                .toString());
                                            Get.to(
                                              () => CreateMessage(
                                                itemId: snapshot.data!.item!.id
                                                    .toString(),
                                              ),
                                            );
                                          },
                                        ),
                                        DetailsButton(
                                          iconData: Icons.location_on_outlined,
                                          name: 'الموقع',
                                          onTap: () async {
                                            openMap(
                                                snapshot.data!.item!.itemLat !=
                                                        null
                                                    ? double.parse(snapshot
                                                        .data!.item!.itemLat!)
                                                    : 41.0082,
                                                snapshot.data!.item!.itemLng !=
                                                        null
                                                    ? double.parse(snapshot
                                                        .data!.item!.itemLng!)
                                                    : 28.9784);
                                          },
                                        ),
                                        DetailsButton(
                                          iconData: Icons.star_border_rounded,
                                          name: 'اضافة تعليق',
                                          onTap: () {
                                            Scrollable.ensureVisible(
                                                addReview.currentContext!);
                                            focusNode.requestFocus();
                                          },
                                        ),
                                        DetailsButton(
                                          iconData: Icons.add_a_photo_outlined,
                                          name: 'إضافة صورة',
                                          onTap: () {
                                            Scrollable.ensureVisible(
                                                addImage.currentContext!);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Column(
                                    children: [
                                      DetailsTabBarScreen(
                                          detailsModel: snapshot.data!,
                                          addImage: addImage,
                                          addReview: addReview,
                                          detailsKey: detailsKey,
                                          rateKey: rateKey,
                                          focusNode: focusNode),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('لا توجد بيانات'));
              }
            },
          ),
        ));
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=41.0082,28.9784';
    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(
        googleUrl,
      );
    } else {
      throw 'Could not open the map.';
    }
  }
}

class SaveItemWidget extends StatelessWidget with Helpers {
  final String id;

  const SaveItemWidget({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(  vertical: 8),
      child: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(0.4),
        child: IconButton(
            onPressed: () async{

              saveItem(id: id);
            },
            icon: const Icon(
              Icons.bookmark_outline_sharp,
              // Icons.bookmark_outlined,
              color: Colors.white,
            )),
      ),
    );
  }

  Future<void> saveItem({required String id}) async {
    bool status = await SaveApiController().saveItem(itemId: id);
    if (status) {
      ShowMySnakbar(
          title: 'تم العملية بنجاح',
          message: 'تم حفظ العنصر بنجاح',
          backgroundColor: Colors.green.shade700);
    } else {
      ShowMySnakbar(
          title: 'خطأ',
          message: 'حدث خطأ ما',
          backgroundColor: Colors.red.shade700);
    }
  }
}

class LeadingSliverAppBarIconDetailsScreen extends StatelessWidget {
  const LeadingSliverAppBarIconDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(0.4),
        child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
    );
  }
}

class DetailsButton extends StatelessWidget {
  final String name;
  final IconData iconData;
  void Function()? onTap;

  DetailsButton(
      {required this.iconData, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.mainColor.withOpacity(.05),
            child: Icon(
              iconData,
              color: AppColors.mainColor,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: GoogleFonts.notoKufiArabic(
                textStyle:
                    const TextStyle(color: Color(0xFFC2C2C2), fontSize: 12)),
          )
        ],
      ),
    );
  }
}
