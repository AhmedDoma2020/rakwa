import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/widget/ButtomSheets/base_bottom_sheet.dart';
import 'package:rakwa/widget/ButtomSheets/row_select_item.dart';

import '../../../model/paid_items_model.dart';

class BottomSheetState extends StatelessWidget {
  final String bottomSheetTitle;
  final int stateSelectedId;
  final Function(StateModel) onSelect;
  final List<StateModel> state;

  const BottomSheetState({
    Key? key,
    required this.stateSelectedId,
    required this.onSelect,
    required this.state, required this.bottomSheetTitle,
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
                onSelect(state[index]);
                Get.back();
              },
              title: state[index].stateName,
              active: stateSelectedId ==
                  state[index].id,
            ),
            separatorBuilder: (context, index) => 16.ESW(),
            itemCount: state.length),
      ),
    );
  }
}
