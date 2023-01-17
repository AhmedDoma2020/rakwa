import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/model/all_categories_model.dart';
import 'package:rakwa/widget/ButtomSheets/base_bottom_sheet.dart';
import 'package:rakwa/widget/ButtomSheets/row_select_item.dart';

class BottomSheetClassification extends StatelessWidget {
  final String bottomSheetTitle;
  final int categorySelectedId;
  final Function(AllCategoriesModel) onSelect;
  final List<AllCategoriesModel> categories;

  const BottomSheetClassification({
    Key? key,
    required this.categorySelectedId,
    required this.onSelect,
    required this.categories, required this.bottomSheetTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      height: 400.h,
      bottomSheetTitle:bottomSheetTitle,
      widget: Expanded(
        child: ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => RowSelectItem(
              onTap: () {
                onSelect(categories[index]);
                Get.back();
              },
              title: categories[index].categoryName,
              active: categorySelectedId ==
                  categories[index].id,
            ),
            separatorBuilder: (context, index) => 16.ESW(),
            itemCount: categories.length),
      ),
    );
  }
}
