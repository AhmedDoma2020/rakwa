import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rakwa/api/api_controllers/item_api_controller.dart';
import 'package:rakwa/controller/all_item_getx_controller.dart';
import 'package:rakwa/model/item_with_category.dart';
import 'package:rakwa/screens/details_screen/details_screen.dart';
import 'package:rakwa/screens/search_screens/search_screen.dart';
import 'package:rakwa/screens/view_all_item_screens/view_all_items_screen.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/category_widget.dart';
import 'package:rakwa/widget/home_widget.dart';
import 'package:rakwa/widget/my_text_field.dart';
import 'package:shimmer/shimmer.dart';

import '../../api/api_controllers/list_api_controller.dart';
import '../../app_colors/app_colors.dart';
import '../../model/all_categories_model.dart';

class ViewAllSubCategoriesScreen extends StatefulWidget {
  final int id;
  final String title;
  const ViewAllSubCategoriesScreen({super.key, required this.id, required this.title});

  @override
  State<ViewAllSubCategoriesScreen> createState() =>
      _ViewAllSubCategoriesScreenState();
}

class _ViewAllSubCategoriesScreenState
    extends State<ViewAllSubCategoriesScreen> {
  List colors = const [
    Color.fromARGB(255, 224, 20, 81),
    Color.fromARGB(255, 45, 106, 228),
    Color.fromARGB(255, 159, 6, 254),
    Color.fromARGB(255, 219, 242, 12),
    Color.fromARGB(255, 224, 20, 81),
    Color.fromARGB(255, 45, 106, 228),
    Color.fromARGB(255, 159, 6, 254),
    Color.fromARGB(255, 219, 242, 12)
  ];
  late TextEditingController _searchController;
  // final Set<Marker> _marker = {};
  AllItemGetxController allItemGetxController =
      Get.put(AllItemGetxController());

  List<Marker> marker = const[
     Marker(markerId: MarkerId('1'), position: LatLng(41.0082, 28.9784)),
    Marker(markerId: MarkerId('2'), position: LatLng(41.0082, 26.9784)),
    Marker(markerId: MarkerId('3'), position: LatLng(49.0082, 28.9784)),
  ];

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
    allItemGetxController.getSubCategory(id: widget.id);
    allItemGetxController.getItem(id: widget.id.toString());
    // addMarkers();
    return Scaffold(
        appBar: AppBars.appBarDefault(title: widget.title,),
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
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 40),
                    child: SizedBox(
                      height: Get.height * 0.7,
                      child: ListView(
                        controller: scrollController,
                        children: [
                          InkWell(
                            onTap: () {
                              print(widget.id.toString());
                              Get.to(() => SearchScreen(
                                    searchNumber: widget.id.toString(),
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
                            height: 70,
                            child: GetBuilder<AllItemGetxController>(
                              builder: (controller) {
                                return allItemGetxController.subCategory.isEmpty
                                    ? Shimmer.fromColors(
                                        baseColor: Colors.grey.shade100,
                                        highlightColor: Colors.grey.shade300,
                                        child: ListView.builder(
                                          itemCount: 8,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {},
                                              child: CategoryWidget(
                                                image: '',
                                                categoryName: '',
                                              ),
                                            );
                                          },
                                        ))
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: allItemGetxController
                                            .subCategory.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              print(allItemGetxController
                                                  .subCategory[index].id);
                                              Get.to(() => ViewAllItems(
                                                    id: allItemGetxController
                                                        .subCategory[index].id,
                                                    categoryId: widget.id,
                                                title: allItemGetxController
                                                    .subCategory[index].categoryName,
                                                  ));
                                            },
                                            child: CategoryWidget(
                                              image:  allItemGetxController
                                                      .subCategory[index]
                                                      .categoryImage,
                                              index: index,
                                              categoryName:
                                                  allItemGetxController
                                                      .subCategory[index]
                                                      .categoryName,
                                            ),
                                          );
                                        },
                                      );
                              },
                            ),
                          ),

                          const SizedBox(
                            height: 24,
                          ),

                          SizedBox(
                            height: Get.height * 0.6,
                            child: GetBuilder<AllItemGetxController>(
                              builder: (controller) {
                                return allItemGetxController
                                        .itemWithCategory.isEmpty
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                        color: AppColors.mainColor,
                                      ),)
                                    : AnimationLimiter(
                                      child: ListView.builder(
                                          physics: const BouncingScrollPhysics(),
                                          itemCount: allItemGetxController
                                              .itemWithCategory[0]
                                              .allItems!
                                              .length,
                                          itemBuilder: (context, index) {
                                          return  AnimationConfiguration.staggeredList(
                                              position: index,
                                              duration: const Duration(milliseconds: 500),
                                              child: SlideAnimation(
                                                verticalOffset: 50.0,
                                                child: FadeInAnimation(
                                                  child: HomeWidget(
                                                    percentCardWidth: .9,
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
                                                          .itemAverageRating),
                                                ),
                                              ),
                                            );


                                          },
                                        ),
                                    );
                              },
                            ),
                          )
                          // SizedBox(
                          //   height: Get.height * 0.6,
                          //   child: FutureBuilder<List<ItemWithCategory>>(
                          //     future: ItemApiController().getItemWithCategory(
                          //         id: widget.id.toString()),
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
                          //                 borderRadius:
                          //                     BorderRadius.circular(12),
                          //                 color: Colors.white,
                          //               ),
                          //             ));
                          //       } else if (snapshot.hasData &&
                          //           snapshot.data!.isNotEmpty) {
                          //         return ListView.builder(
                          //           physics: const BouncingScrollPhysics(),
                          //           itemCount:
                          //               snapshot.data![0].allItems!.length,
                          //           itemBuilder: (context, index) {
                          //             return HomeWidget(
                          //                 onTap: () {
                          //                   Get.to(() => DetailsScreen(
                          //                       id: snapshot.data![0]
                          //                           .allItems![index].id!));
                          //                 },
                          //                 discount: '25',
                          //                 image: snapshot.data![0]
                          //                     .allItems![index].itemImage,
                          //                 itemType: snapshot
                          //                     .data![0]
                          //                     .allItems![index]
                          //                     .itemCategoriesString!,
                          //                 location: snapshot
                          //                             .data![0]
                          //                             .allItems![index]
                          //                             .cityId !=
                          //                         null
                          //                     ? snapshot.data![0]
                          //                         .allItems![index].cityId
                          //                         .toString()
                          //                     : '',
                          //                 title: snapshot.data![0]
                          //                     .allItems![index].itemTitle!,
                          //                 rate: snapshot
                          //                     .data![0]
                          //                     .allItems![index]
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
                          // )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ));
  }

  // void showMySheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return DraggableScrollableSheet(
  //         initialChildSize: 0.9,
  //         builder: (context, scrollController) {
  //           return Container(
  //             color: Colors.white,
  //             child: Padding(
  //               padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
  //               child: Column(
  //                 children: [
  //                   InkWell(
  //                     onTap: () {
  //                       Get.to(() => SearchScreen(
  //                             searchNumber: widget.id.toString(),
  //                           ));
  //                     },
  //                     child: MyTextField(
  //                         enabled: false,
  //                         onChanged: (p0) {
  //                           setState(() {});
  //                         },
  //                         hint: 'ابحث عن',
  //                         controller: _searchController,
  //                         suffixIcon: IconButton(
  //                           onPressed: () {
  //                             // _focusNode.requestFocus();
  //                           },
  //                           icon: const Icon(
  //                             Icons.filter_list_sharp,
  //                             color: Colors.black,
  //                           ),
  //                         ),
  //                         prefixIcon: const Icon(
  //                           Icons.search,
  //                           color: AppColors.mainColor,
  //                         )),
  //                   ),
  //                   const SizedBox(
  //                     height: 24,
  //                   ),
  //                   SizedBox(
  //                     height: 70,
  //                     child: FutureBuilder<List<AllCategoriesModel>>(
  //                       future:
  //                           ListApiController().getSubCategory(id: widget.id),
  //                       builder: (context, snapshot) {
  //                         if (snapshot.connectionState ==
  //                             ConnectionState.waiting) {
  //                           return Shimmer.fromColors(
  //                               baseColor: Colors.grey.shade100,
  //                               highlightColor: Colors.grey.shade300,
  //                               child: ListView.builder(
  //                                 itemCount: 8,
  //                                 scrollDirection: Axis.horizontal,

  //                                 // gridDelegate:
  //                                 //     const SliverGridDelegateWithFixedCrossAxisCount(
  //                                 //   crossAxisCount: 4,
  //                                 //   crossAxisSpacing: 31,
  //                                 //   mainAxisSpacing: 24,
  //                                 //   mainAxisExtent: 60,
  //                                 // ),
  //                                 itemBuilder: (context, index) {
  //                                   return InkWell(
  //                                     onTap: () {},
  //                                     child: CategoryWidget(
  //                                       categoryName: '',
  //                                     ),
  //                                   );
  //                                 },
  //                               ));
  //                         } else if (snapshot.hasData &&
  //                             snapshot.data!.isNotEmpty) {
  //                           return ListView.builder(
  //                             scrollDirection: Axis.horizontal,
  //                             physics: const BouncingScrollPhysics(),
  //                             itemCount: snapshot.data!.length,
  //                             itemBuilder: (context, index) {
  //                               return InkWell(
  //                                 onTap: () {
  //                                   Get.to(() => ViewAllItems(
  //                                         id: snapshot.data![index].id,
  //                                         categoryId: widget.id,
  //                                       ));
  //                                 },
  //                                 child: CategoryWidget(
  //                                   index: index,
  //                                   categoryName:
  //                                       snapshot.data![index].categoryName,
  //                                 ),
  //                               );
  //                             },
  //                           );
  //                         } else {
  //                           return const Center(
  //                             child: Text('لا توجد اي تصنفيات '),
  //                           );
  //                         }
  //                       },
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 24,
  //                   ),
  //                   Expanded(
  //                     child: FutureBuilder<List<ItemWithCategory>>(
  //                       future: ItemApiController()
  //                           .getItemWithCategory(id: widget.id.toString()),
  //                       builder: (context, snapshot) {
  //                         if (snapshot.connectionState ==
  //                             ConnectionState.waiting) {
  //                           return Shimmer.fromColors(
  //                               baseColor: Colors.grey.shade100,
  //                               highlightColor: Colors.grey.shade300,
  //                               child: Container(
  //                                 margin: const EdgeInsets.only(left: 8),
  //                                 height: 236,
  //                                 width: Get.width * 0.9,
  //                                 decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(12),
  //                                   color: Colors.white,
  //                                 ),
  //                               ));
  //                         } else if (snapshot.hasData &&
  //                             snapshot.data!.isNotEmpty) {
  //                           return ListView.builder(
  //                             physics: const BouncingScrollPhysics(),
  //                             itemCount: snapshot.data![0].allItems!.length,
  //                             itemBuilder: (context, index) {
  //                               return HomeWidget(
  //                                   onTap: () {
  //                                     Get.to(() => DetailsScreen(
  //                                         id: snapshot
  //                                             .data![0].allItems![index].id!));
  //                                   },
  //                                   discount: '25',
  //                                   image: snapshot
  //                                       .data![0].allItems![index].itemImage,
  //                                   itemType: snapshot.data![0].allItems![index]
  //                                       .itemCategoriesString!,
  //                                   location: snapshot.data![0].allItems![index]
  //                                               .cityId !=
  //                                           null
  //                                       ? snapshot
  //                                           .data![0].allItems![index].cityId
  //                                           .toString()
  //                                       : '',
  //                                   title: snapshot
  //                                       .data![0].allItems![index].itemTitle!,
  //                                   rate: snapshot.data![0].allItems![index]
  //                                       .itemAverageRating);
  //                             },
  //                           );
  //                         } else {
  //                           return const Center(
  //                             child: Text('لا توجد اي عناصر '),
  //                           );
  //                         }
  //                       },
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
}
