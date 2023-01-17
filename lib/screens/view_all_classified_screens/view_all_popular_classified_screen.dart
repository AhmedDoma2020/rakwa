import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/screens/details_screen/details_classified_screen.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:shimmer/shimmer.dart';

import '../../api/api_controllers/home_api_controller.dart';
import '../../model/paid_items_model.dart';
import '../../widget/home_widget.dart';

class ViewAllPopularClassifiedScreen extends StatefulWidget {
  const ViewAllPopularClassifiedScreen({super.key});

  @override
  State<ViewAllPopularClassifiedScreen> createState() =>
      _ViewAllPopularClassifiedScreenState();
}

class _ViewAllPopularClassifiedScreenState
    extends State<ViewAllPopularClassifiedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarDefault(title: "الاعلانات الأشهر"),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
        child: FutureBuilder<List<PaidItemsModel>>(
          future: HomeApiController().getPopularClassified(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Shimmer.fromColors(
                  baseColor: Colors.grey.shade100,
                  highlightColor: Colors.grey.shade300,
                  child: ListView.separated(padding: EdgeInsets.zero,
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
                  separatorBuilder: (context, index) => 16.ESH(),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: HomeWidget(
                            isList: true,
                            percentCardWidth: .9,
                            onTap: () {
                              Get.to(
                                () => DetailsClassifiedScreen(
                                  id: snapshot.data![index].id,
                                ),
                              );
                            },
                            discount: '25',
                            image: snapshot.data![index].itemImage,
                            itemType:
                                snapshot.data![index].state?.stateName ?? '',
                            location:
                                snapshot.data![index].city?.cityName ?? '',
                            title: snapshot.data![index].itemTitle,
                            rate: '100',
                          ),
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
