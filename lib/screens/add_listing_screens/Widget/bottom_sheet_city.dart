import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/model/city_model.dart';
import 'package:rakwa/widget/ButtomSheets/base_bottom_sheet.dart';
import 'package:rakwa/widget/ButtomSheets/row_select_item.dart';

class BottomSheetCity extends StatelessWidget {
  final String bottomSheetTitle;
  final int citySelectedId;
  final Function(CityModel) onSelect;
  final List<CityModel> cities;

  const BottomSheetCity({
    Key? key,
    required this.citySelectedId,
    required this.onSelect,
    required this.cities, required this.bottomSheetTitle,
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
                onSelect(cities[index]);
                Get.back();
              },
              title: cities[index].cityName,
              active: citySelectedId ==
                  cities[index].id,
            ),
            separatorBuilder: (context, index) => 16.ESW(),
            itemCount: cities.length),
      ),
    );
  }
}
