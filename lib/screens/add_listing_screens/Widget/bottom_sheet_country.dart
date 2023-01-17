import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/model/country_model.dart';
import 'package:rakwa/widget/ButtomSheets/base_bottom_sheet.dart';
import 'package:rakwa/widget/ButtomSheets/row_select_item.dart';

class BottomSheetCountry extends StatelessWidget {
  final String bottomSheetTitle;
  final int countrySelectedId;
  final Function(CountryModel) onSelect;
  final List<CountryModel> country;

  const BottomSheetCountry({
    Key? key,
    required this.countrySelectedId,
    required this.onSelect,
    required this.country, required this.bottomSheetTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      height: 300.h,
      bottomSheetTitle:bottomSheetTitle,
      widget: Expanded(
        child: ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => RowSelectItem(
              onTap: () {
                onSelect(country[index]);
                Get.back();
              },
              title: country[index].countryName,
              active: countrySelectedId ==
                  country[index].id,
            ),
            separatorBuilder: (context, index) => 16.ESW(),
            itemCount: country.length),
      ),
    );
  }
}
