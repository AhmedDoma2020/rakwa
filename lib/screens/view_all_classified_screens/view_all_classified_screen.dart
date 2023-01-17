import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rakwa/api/api_controllers/classified_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/controller/all_item_getx_controller.dart';
import 'package:rakwa/model/classified_with_category.dart';
import 'package:rakwa/screens/details_screen/details_classified_screen.dart';
import 'package:rakwa/screens/details_screen/details_screen.dart';
import 'package:rakwa/screens/search_screens/search_screen.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/home_widget.dart';
import 'package:rakwa/widget/my_text_field.dart';
import 'package:shimmer/shimmer.dart';

class ViewAllClassifiedScreen extends StatefulWidget {
  final int id;
  final int categoryId;
  final String categoryName;

  ViewAllClassifiedScreen({required this.id, required this.categoryId, required this.categoryName});

  @override
  State<ViewAllClassifiedScreen> createState() =>
      _ViewAllClassifiedScreenState();
}

class _ViewAllClassifiedScreenState extends State<ViewAllClassifiedScreen> {
  late TextEditingController _searchController;
  final Set<Marker> _marker = {};
  AllItemGetxController allItemGetxController =
      Get.put(AllItemGetxController());

  @override
  void initState() {
    super.initState();
    print(widget.id);
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    allItemGetxController.getClassified(id: widget.id.toString());

    return Scaffold(
      appBar: AppBars.appBarDefault(title: widget.categoryName),
      body: Stack(
        children: [
          GetBuilder<AllItemGetxController>(
            builder: (controller) {
              return GoogleMap(
                markers: Set<Marker>.of(allItemGetxController.markerClassified),
                mapType: MapType.normal,
                myLocationEnabled: true,
                initialCameraPosition: const CameraPosition(
                    target: LatLng(34.817411, 34.615960), zoom: 5),
              );
            },
          ),
          DraggableScrollableSheet(
            maxChildSize: 0.9,
            minChildSize: 0.2,
            initialChildSize: 0.7,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: ListView(
                  controller: scrollController,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => SearchScreen(
                            isItem: false,
                            searchNumber: '${widget.categoryId},${widget.id}',
                          ),
                        );
                      },
                      child: MyTextField(
                          enabled: false,
                          onChanged: (p0) {
                            setState(() {});
                          },
                          hint: 'ابحث عن',
                          controller: _searchController,
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.filter_list_sharp,
                              color: Colors.black,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.mainColor,
                          )),
                    ),
                    const SizedBox(
                      height: 24,
                    ),

                    SizedBox(
                      height: Get.height * 0.8,
                      child: GetBuilder<AllItemGetxController>(
                        builder: (controller) {
                          return allItemGetxController
                                      .classifiedWithCategory.isEmpty &&
                                  allItemGetxController.classifiedStatus == 1
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: AppColors.mainColor,
                                ))
                              : allItemGetxController
                                      .classifiedWithCategory.isNotEmpty
                                  ? ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: allItemGetxController
                                          .classifiedWithCategory[0]
                                          .allItems!
                                          .length,
                                      itemBuilder: (context, index) {
                                        return HomeWidget(
                                            onTap: () {
                                              Get.to(() =>
                                                  DetailsClassifiedScreen(
                                                      id: allItemGetxController
                                                          .classifiedWithCategory[
                                                              0]
                                                          .allItems![index]
                                                          .id!));
                                            },
                                            discount: '25',
                                            image: allItemGetxController
                                                .classifiedWithCategory[0]
                                                .allItems![index]
                                                .itemImage,
                                            itemType: allItemGetxController
                                                .classifiedWithCategory[0]
                                                .allItems![index]
                                                .itemCategoriesString!,
                                            location: allItemGetxController
                                                        .classifiedWithCategory[
                                                            0]
                                                        .allItems![index]
                                                        .cityId !=
                                                    null
                                                ? allItemGetxController
                                                    .classifiedWithCategory[0]
                                                    .allItems![index]
                                                    .cityId
                                                    .toString()
                                                : '',
                                            title: allItemGetxController
                                                .classifiedWithCategory[0]
                                                .allItems![index]
                                                .itemTitle!,
                                            rate: '100');
                                      },
                                    )
                                  : const Center(
                                      child: Text('لا توجد بيانات'),
                                    );
                        },
                      ),
                    ),
                    // SizedBox(
                    //   height: Get.height * 0.6,
                    //   child: FutureBuilder<List<ClassifiedWithCategory>>(
                    //     future: ClassifiedApiController()
                    //         .getClassifedWithCategory(id: widget.id.toString()),
                    //     builder: (context, snapshot) {
                    //       if (snapshot.connectionState ==
                    //           ConnectionState.waiting) {
                    //         return Shimmer.fromColors(
                    //             baseColor: Colors.grey.shade100,
                    //             highlightColor: Colors.grey.shade300,
                    //             child: Container(
                    //               margin: const EdgeInsets.only(left: 8),
                    //               height: 236,
                    //               width: Get.width * 0.9,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(12),
                    //                 color: Colors.white,
                    //               ),
                    //             ));
                    //       } else if (snapshot.hasData &&
                    //           snapshot.data!.isNotEmpty) {
                    //         return ListView.builder(
                    //           physics: const BouncingScrollPhysics(),
                    //           itemCount: snapshot.data![0].allItems!.length,
                    //           itemBuilder: (context, index) {
                    //             return HomeWidget(
                    //                 onTap: () {
                    //                   Get.to(() => DetailsClassifiedScreen(
                    //                       id: snapshot.data![index].id!));
                    //                 },
                    //                 discount: '25',
                    //                 image: snapshot
                    //                     .data![0].allItems![index].itemImage,
                    //                 itemType: snapshot.data![0].allItems![index]
                    //                     .itemCategoriesString!,
                    //                 location: snapshot.data![0].allItems![index]
                    //                             .cityId !=
                    //                         null
                    //                     ? snapshot
                    //                         .data![0].allItems![index].cityId
                    //                         .toString()
                    //                     : '',
                    //                 title: snapshot
                    //                     .data![0].allItems![index].itemTitle!,
                    //                 rate: snapshot.data![0].allItems![index]
                    //                     .itemAverageRating);
                    //           },
                    //         );
                    //       } else {
                    //         return const Center(
                    //           child: Text('لا توجد اي عناصر '),
                    //         );
                    //       }
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
