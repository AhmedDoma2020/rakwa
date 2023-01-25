import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/screens/details_screen/details_screen.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:shimmer/shimmer.dart';

import '../../api/api_controllers/home_api_controller.dart';
import '../../model/paid_items_model.dart';
import '../../widget/home_widget.dart';

class ViewAllLatestItemScreen extends StatefulWidget {
  const ViewAllLatestItemScreen({super.key});

  @override
  State<ViewAllLatestItemScreen> createState() =>
      _ViewAllLatestItemScreenState();
}

class _ViewAllLatestItemScreenState extends State<ViewAllLatestItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarDefault(title: "الأحدث"),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
        child: FutureBuilder<List<PaidItemsModel>>(
          future: HomeApiController().getLatestItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Shimmer.fromColors(
                  baseColor: Colors.grey.shade100,
                  highlightColor: Colors.grey.shade300,
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    height: 236,
                    width: Get.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                  ));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return AnimationLimiter(
                child: ListView.separated(
                  separatorBuilder: (context, index) => 16.ESH(),

                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: HomeWidget(
                              isList: true,
percentCardWidth: .9,
                              onTap: () {
                                Get.to(() => DetailsScreen(
                                    id: snapshot.data![index].id.toString()));
                              },
                              discount: '25',
                              image: snapshot.data![index].itemImage,
                              itemType:
                                  snapshot.data![index].itemCategoriesString,
                              location: snapshot.data![index].city != null
                                  ? snapshot.data![index].city!.cityName
                                  : '',
                              title: snapshot.data![index].itemTitle,
                              rate: snapshot.data![index].itemAverageRating),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: Text('لا توجد اي عناصر '),
              );
            }
          },
        ),
      ),
    );
  }
}
