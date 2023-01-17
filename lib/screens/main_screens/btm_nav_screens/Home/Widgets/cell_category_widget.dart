import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakwa/model/all_categories_model.dart';
import 'package:rakwa/screens/view_all_item_screens/view_all_categories_screen.dart';
import '../../../../../widget/category_widget.dart';
import '../../../../view_all_item_screens/view_all_subcategories_screen.dart';

class CellCategoryWidget extends StatelessWidget {
  final List<AllCategoriesModel> data;

  CellCategoryWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  List<AllCategoriesModel> allCaAllCategories = [];
  AllCategoriesModel moreItem =
      AllCategoriesModel(id: -1, categoryName: "المزيد", categoryImage: "");

  @override
  Widget build(BuildContext context) {
    allCaAllCategories.addAll(data);
    allCaAllCategories.insert(allCaAllCategories.length, moreItem);
    return GridView.builder(
      padding: EdgeInsets.zero,

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: allCaAllCategories.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
          tapInCategory(index);
          },
          child: CategoryWidget(
            image: allCaAllCategories[index].categoryImage,
            index: index,
            categoryName: allCaAllCategories[index].categoryName,
            isMore: allCaAllCategories[index].id == -1,
          ),
        );
      },
    );
  }

  void tapInCategory(int index) {
    if (allCaAllCategories[index].id != -1) {
      Get.to(
            () => ViewAllSubCategoriesScreen(
          id: allCaAllCategories[index].id,
          title: allCaAllCategories[index].categoryName,
        ),
      );
    } else {
      Get.to(() => const ViewAllCategoriesScreen());
    }
  }
}