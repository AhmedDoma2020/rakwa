import 'package:flutter/material.dart';
import 'package:rakwa/api/api_controllers/home_api_controller.dart';
import 'package:rakwa/model/all_categories_model.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Home/Widgets/cell_category_widget.dart';
import 'package:shimmer/shimmer.dart';



class SliderHomeCategories extends StatelessWidget {
  const SliderHomeCategories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: FutureBuilder<List<AllCategoriesModel>>(
          future:
          HomeApiController().getAllCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade100,
                highlightColor: Colors.grey.shade300,
                child: const SizedBox(
                  height: 180,
                ),
              );
            } else if (snapshot.hasData &&
                snapshot.data!.isNotEmpty) {
              return CellCategoryWidget(
                data: snapshot.data!,
              );
            } else {
              return const Center(
                child: Text('لا توجد اي تصنفيات '),
              );
            }
          },
        ));
  }
}
