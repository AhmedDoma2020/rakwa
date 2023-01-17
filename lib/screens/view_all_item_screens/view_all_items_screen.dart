import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_controllers/item_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/controller/all_item_getx_controller.dart';
import 'package:rakwa/model/item_with_category.dart';
import 'package:rakwa/screens/details_screen/details_screen.dart';
import 'package:rakwa/screens/search_screens/search_screen.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/home_widget.dart';
import 'package:rakwa/widget/my_text_field.dart';
import 'package:shimmer/shimmer.dart';

class ViewAllItems extends StatefulWidget {
  final int id;
  final int categoryId;
  final String title;
  const ViewAllItems({super.key, required this.id, required this.categoryId, required this.title});

  @override
  State<ViewAllItems> createState() => _ViewAllItemsState();
}

class _ViewAllItemsState extends State<ViewAllItems> {
  late TextEditingController _searchController;
  final Set<Marker> _marker = {};
  AllItemGetxController allItemGetxController =
      Get.put(AllItemGetxController());

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    allItemGetxController.getItem(id: widget.id.toString());

    return Scaffold(
        appBar: AppBars.appBarDefault(title: widget.title),
        body: Stack(
          children: [
           GetBuilder<AllItemGetxController>(
              builder: (controller) {
                return GoogleMap(
                  markers: Set<Marker>.of(allItemGetxController.marker),
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  initialCameraPosition:
                      const CameraPosition(target: LatLng(34.817411, 34.615960),zoom: 5),
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
                          Get.to(() => SearchScreen(
                                searchNumber:
                                    '${widget.categoryId},${widget.id}',
                                    isItem: true,
                              ));
                        },
                        child: MyTextField(
                            enabled: false,
                            onChanged: (p0) {
                              setState(() {});
                            },
                            hint: 'ابحث عن',
                            controller: _searchController,
                            suffixIcon: IconButton(
                              onPressed: () {
                                // _focusNode.requestFocus();
                              },
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
                                    .itemWithCategory.isEmpty
                                ? const Center(
                                    child: CircularProgressIndicator(
                                    color: AppColors.mainColor,
                                  ))
                                : ListView.separated(
                              separatorBuilder: (context, index) => 16.ESH(),
                              physics: const BouncingScrollPhysics(),
                                    itemCount: allItemGetxController
                                        .itemWithCategory[0].allItems!.length,
                                    itemBuilder: (context, index) {
                                      return HomeWidget(
                                          isList: true,percentCardWidth: .9,
                                          onTap: () {
                                            Get.to(() => DetailsScreen(
                                                id: allItemGetxController
                                                    .itemWithCategory[0]
                                                    .allItems![index]
                                                    .id!));
                                          },
                                          discount: '25',
                                          image: allItemGetxController
                                              .itemWithCategory[0]
                                              .allItems![index]
                                              .itemImage,
                                          itemType: allItemGetxController
                                              .itemWithCategory[0]
                                              .allItems![index]
                                              .itemCategoriesString!,
                                          location: allItemGetxController
                                                      .itemWithCategory[0]
                                                      .allItems![index]
                                                      .cityId !=
                                                  null
                                              ? allItemGetxController
                                                  .itemWithCategory[0]
                                                  .allItems![index]
                                                  .cityId
                                                  .toString()
                                              : '',
                                          title: allItemGetxController
                                              .itemWithCategory[0]
                                              .allItems![index]
                                              .itemTitle!,
                                          rate: allItemGetxController
                                              .itemWithCategory[0]
                                              .allItems![index]
                                              .itemAverageRating);
                                    },
                                  );
                          },
                        ),
                      )
                      // SizedBox(
                      //   height: Get.height * 0.6,
                      //   child: FutureBuilder<List<ItemWithCategory>>(
                      //     future:
                      //         ItemApiController().getItemWithCategory(id: widget.id.toString()),
                      //     builder: (context, snapshot) {
                      //       if (snapshot.connectionState == ConnectionState.waiting) {
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
                      //       } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      //         return ListView.builder(
                      //           physics: const BouncingScrollPhysics(),
                      //           itemCount: snapshot.data![0].allItems!.length,
                      //           itemBuilder: (context, index) {
                      //             return HomeWidget(
                      //                 onTap: () {
                      //                   Get.to(() => DetailsScreen(
                      //                       id: snapshot.data![0].allItems![index].id!));
                      //                 },
                      //                 discount: '25',
                      //                 image: snapshot.data![0].allItems![index].itemImage,
                      //                 itemType: snapshot
                      //                     .data![0].allItems![index].itemCategoriesString!,
                      //                 location: snapshot.data![0].allItems![index].cityId != null
                      //                     ? snapshot.data![0].allItems![index].cityId.toString()
                      //                     : '',
                      //                 title: snapshot.data![0].allItems![index].itemTitle!,
                      //                 rate: snapshot.data![0].allItems![index].itemAverageRating);
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
            ),
          ],
        ));
  }
}
