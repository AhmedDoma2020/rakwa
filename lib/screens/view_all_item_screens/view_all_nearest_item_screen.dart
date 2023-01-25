import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/screens/details_screen/details_screen.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:shimmer/shimmer.dart';

import '../../api/api_controllers/home_api_controller.dart';
import '../../app_colors/app_colors.dart';
import '../../model/paid_items_model.dart';
import '../../widget/home_widget.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ViewAllNearestItemScreen extends StatefulWidget {
  const ViewAllNearestItemScreen({super.key});

  @override
  State<ViewAllNearestItemScreen> createState() => _ViewAllNearestItemScreenState();
}

class _ViewAllNearestItemScreenState extends State<ViewAllNearestItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarDefault(title: "الاعمال الاقرب اليك"),
      body: FutureBuilder<List<PaidItemsModel>>(
        future: HomeApiController().getNearestItems(type: 0),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer.fromColors(
                baseColor: Colors.grey.shade100,
                highlightColor: Colors.grey.shade300,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 12,
                    );
                  },
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(left: 8),
                      height: 236,
                      width: Get.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                    );
                  },
                ));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return AnimationLimiter(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => 16.ESH(),
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
                              Get.to(() =>
                                  DetailsScreen(id: snapshot.data![index].id.toString()));
                            },
                            doMargin: false,
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
    );
  }
}
