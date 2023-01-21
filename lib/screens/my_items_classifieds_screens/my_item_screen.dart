import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakwa/api/api_controllers/item_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/model/item_by_id_model.dart';
import 'package:rakwa/screens/details_screen/details_screen.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';

import '../../widget/home_widget.dart';

class MyItemScreen extends StatefulWidget {
  const MyItemScreen({super.key});

  @override
  State<MyItemScreen> createState() => _MyItemScreenState();
}

class _MyItemScreenState extends State<MyItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarDefault(title: "مشاريعي"),
      body: FutureBuilder<List<ItemByIdModel>>(
        future: ItemApiController().getItemById(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 12,
                );
              },
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return HomeWidget(
                    percentCardWidth: .9,
                    onTap: () {
                      print(snapshot.data![index].id);
                      Get.to(
                        () => DetailsScreen(
                          id: snapshot.data![index].id!.toString(),
                        ),
                      );
                    },
                    discount: '25',
                    image: snapshot.data![index].itemImage,
                    itemType: snapshot.data![index].itemCategoriesString ?? '',
                    location: snapshot.data![index].itemAddress != null
                        ? snapshot.data![index].itemAddress!
                        : '',
                    title: snapshot.data![index].itemTitle ?? '',
                    rate: snapshot.data![index].itemAverageRating);
              },
            );
          } else {
            return const Center(
              child: Text('لا يوجد اعلانات'),
            );
          }
        },
      ),
    );
  }
}
