import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:html/parser.dart';
import 'package:rakwa/api/api_controllers/details_api_controller.dart';
import 'package:rakwa/api/api_controllers/save_api_controller.dart';
import 'package:rakwa/controller/show_title_getx_controller.dart';
import 'package:rakwa/model/details_calssified_model.dart';
import 'package:rakwa/screens/details_screen/details_screen.dart';
import 'package:rakwa/screens/details_screen/tab_bar_screens/details_classified_tab_bar_screen.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../app_colors/app_colors.dart';

class DetailsClassifiedScreen extends StatefulWidget {
  final int id;

  DetailsClassifiedScreen({super.key, required this.id});

  @override
  State<DetailsClassifiedScreen> createState() =>
      _DetailsClassifiedScreenState();
}

class _DetailsClassifiedScreenState extends State<DetailsClassifiedScreen>
    with SingleTickerProviderStateMixin, Helpers {
  final rateClassifiedKey = new GlobalKey();
  final detailsClassifiedKey = new GlobalKey();
  ScrollController scrollController = ScrollController();
  ShowTitleGetxController showTitleGetxController =
      Get.put(ShowTitleGetxController());

  late TabController _tabController;
  bool showWorkHour = false;
  final Set<Marker> _marker = {};

  void _setMarker({required var detailsModel}) {
    _marker.add(
      Marker(
        markerId: const MarkerId('value'),
        position: LatLng(
            detailsModel.item!.itemLat != null
                ? double.parse(
                    detailsModel.item!.itemLat!,
                  )
                : 41.0082,
            detailsModel.item!.itemLng != null
                ? double.parse(
                    detailsModel.item!.itemLng!,
                  )
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
    scrollController.addListener(() {
      if (scrollController.offset > 260) {
        // do what ever you want when silver is collapsing !
        showTitleGetxController.showTitle(newShow: true);
      }
      if (scrollController.offset <= 260) {
        showTitleGetxController.showTitle(newShow: false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
          backgroundColor: Colors.grey.shade300,
          body: FutureBuilder<DetailsClassifiedModel?>(
            future: DetailsApiController()
                .getClassifiedDetails(id: widget.id.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                );
              } else if (snapshot.hasData) {
                bool show = false;
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
                        SaveItemWidget(
                          id: snapshot.data!.classified!.id.toString(),
                        ),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        title: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              // color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                // color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              snapshot.data!.classified!.itemTitle!,
                              style: GoogleFonts.notoKufiArabic(
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        titlePadding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 40,
                        ),
                        background: SizedBox(
                          height: 254,
                          width: Get.width,
                          child: Stack(
                            children: [
                              TopDetailsClassifiedWidget(snapshot: snapshot),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              child: SizedBox(
                                height: 35,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: snapshot
                                      .data!.classified!.allCategories!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 12,
                                      ),
                                      margin: const EdgeInsets.only(left: 5),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.blueAccent,
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                            255,
                                            170,
                                            234,
                                            247,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        snapshot
                                            .data!
                                            .classified!
                                            .allCategories![index]
                                            .categoryName!,
                                        style: GoogleFonts.notoKufiArabic(
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
                              ),
                            ),
                          ),
                          DetailsClassifiedTabBarScreen(
                            detailsModel: snapshot.data!,
                            rateClassifiedKey: rateClassifiedKey,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                print("snapshot.hasData is => ${snapshot.data}");
                return const Center(child: Text('لا توجد بيانات'));
              }
            },
          )),
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

class TopDetailsClassifiedWidget extends StatelessWidget with Helpers {
  final AsyncSnapshot<DetailsClassifiedModel?> snapshot;

  const TopDetailsClassifiedWidget({Key? key, required this.snapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CarouselController buttonCarouselController = Get.put(CarouselController());
    return SizedBox(
      height: 254,
      width: Get.width,
      child: Stack(
        children: [
          snapshot.data!.classified!.galleries != null &&
                  snapshot.data!.classified!.galleries!.isNotEmpty
              ? CarouselSlider(
                  carouselController: buttonCarouselController,
                  options: CarouselOptions(height: 400.0),
                  items: snapshot.data!.classified!.galleries!.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: Get.width,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Stack(
                            children: [
                              Image.network(
                                'https://www.rakwa.com/laravel_project/public/storage/item/gallery/${i.itemImageGalleryName}',
                                fit: BoxFit.cover,
                                width: Get.width,
                                height: 400,
                              ),
                              Positioned.fill(
                                child: Opacity(
                                  opacity: 0.5,
                                  child: Container(
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                )
              : Stack(
                  children: [
                    Image.network(
                      'https://www.rakwa.com/laravel_project/public/storage/item/${snapshot.data!.classified!.itemImage}',
                      fit: BoxFit.fitWidth,
                      width: Get.width,
                    ),
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.5,
                        child: Container(
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ),
                  ],
                ),

          // Image.network(
          //   'https://www.rakwa.com/laravel_project/public/storage/item/${snapshot.data!.classified!.itemImage}',
          //   fit: BoxFit.fitWidth,
          //   width: Get.width,
          // ),
          // Positioned.fill(
          //   child: Opacity(
          //     opacity: 0.5,
          //     child: Container(
          //       color: const Color(0xFF000000),
          //     ),
          //   ),
          // ),

          // Positioned(
          //   right: 16,
          //   bottom: 19,
          //   child: RateStarsWidget(
          //       rate: snapshot.data!.item!.itemAverageRating),
          // ),
        ],
      ),
    );
  }

  Future<void> saveItem({required String id}) async {
    bool status = await SaveApiController().saveClassified(classifiedId: id);
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
