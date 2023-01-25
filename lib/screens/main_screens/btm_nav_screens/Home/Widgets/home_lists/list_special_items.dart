
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_controllers/home_api_controller.dart';
import 'package:rakwa/model/paid_items_model.dart';
import 'package:rakwa/screens/details_screen/details_screen.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Ads/Screens/ads_screen.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Home/Widgets/shimmer_card_home_loading.dart';
import 'package:rakwa/widget/home_widget.dart';

class SpecialItems extends StatelessWidget {
  const SpecialItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PaidItemsModel>>(
      future: HomeApiController().getPaidItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const ShimmerCardHomeLoading();
        } else if (snapshot.hasData &&
            snapshot.data!.isNotEmpty) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics:
            const NeverScrollableScrollPhysics(),
            // scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length <= 8
                ? snapshot.data!.length
                : 8,
            separatorBuilder: (context, index) =>
                16.ESH(),
            itemBuilder: (context, index) {
              return HomeWidget(
                percentCardWidth: .9,
                isList: true,
                onTap: () {
                  Get.to(
                        () => DetailsScreen(
                      id: snapshot.data![index].id.toString(),
                    ),
                  );
                },
                saveOnPressed: () => saveItem(
                    id: snapshot.data![index].id
                        .toString()),
                discount: '25',
                image: snapshot.data![index].itemImage,
                itemType: snapshot
                    .data![index].itemCategoriesString,
                location:
                snapshot.data![index].city != null
                    ? snapshot
                    .data![index].city!.cityName
                    : '',
                title: snapshot.data![index].itemTitle,
                rate: snapshot
                    .data![index].itemAverageRating,
              );
            },
          );
        } else {
          return const Center(
            child: Text('لا توجد اي عناصر '),
          );
        }
      },
    );
  }
}
