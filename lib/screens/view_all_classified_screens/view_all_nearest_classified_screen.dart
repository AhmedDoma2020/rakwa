import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_controllers/home_api_controller.dart';
import 'package:rakwa/model/paid_items_model.dart';
import 'package:rakwa/screens/details_screen/details_classified_screen.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/home_widget.dart';
import 'package:shimmer/shimmer.dart';


class ViewAllNearestClassifiedScreen extends StatelessWidget {
  const ViewAllNearestClassifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarDefault(title: "الاعلانات الاقرب اليك"),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
        child: FutureBuilder<List<PaidItemsModel>>(
          future: HomeApiController().getNearestClassified(type: 1),
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
