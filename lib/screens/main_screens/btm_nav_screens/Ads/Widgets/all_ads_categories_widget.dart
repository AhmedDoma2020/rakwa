import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakwa/screens/view_all_classified_screens/view_all_classified_subcategories_screen.dart';
import 'package:rakwa/widget/category_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../api/api_controllers/home_api_controller.dart';
import '../../../../../model/all_categories_model.dart';



class AllAdsCategoriesWidget extends StatelessWidget {
  const AllAdsCategoriesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: SizedBox(
        height: 80,
        child: FutureBuilder<List<AllCategoriesModel>>(
          future: HomeApiController().getAllClassifiedCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Shimmer.fromColors(
                  baseColor: Colors.grey.shade100,
                  highlightColor: Colors.grey.shade300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: CategoryWidget(
                          categoryName: '',
                          image: '',
                        ),
                      );
                    },
                  ));
            } else if (snapshot.hasData &&
                snapshot.data!.isNotEmpty) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length <= 8
                    ? snapshot.data!.length
                    : 8,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(
                            () => ViewAllClassifiedSubCategoriesScreen(
                          id: snapshot.data![index].id,
                          categoryName:
                          snapshot.data![index].categoryName,
                        ),
                      );
                    },
                    child: CategoryWidget(
                        index: index,
                        image: snapshot.data![index].categoryImage,
                        categoryName:
                        snapshot.data![index].categoryName),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('لا توجد اي تصنفيات '),
              );
            }
          },
        ),
      ),
    );
  }
}
