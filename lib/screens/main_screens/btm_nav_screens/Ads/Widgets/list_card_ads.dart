
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/screens/details_screen/details_classified_screen.dart';

import '../../../../../api/api_controllers/save_api_controller.dart';
import '../../../../../model/paid_items_model.dart';
import '../../../../../widget/home_widget.dart';



class ListCardAds extends StatelessWidget  {
  final int length;
  final List<PaidItemsModel> ads;

  const ListCardAds({
    Key? key,
    required this.length,
    required this.ads,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: length <= 8 ? length : 8,
      separatorBuilder: (context, index) => 16.ESH(),
      itemBuilder: (context, index) {
        return HomeWidget(
          isList: true,
          percentCardWidth: .9,
          onTap: () {
            Get.to(() => DetailsClassifiedScreen(id: ads[index].id));
          },
          saveOnPressed: () => saveItem(id: ads[index].id.toString()),
          discount: '25',
          image: ads[index].itemImage,
          itemType: ads[index].state?.stateName ?? '',
          location: ads[index].city?.cityName ?? '',
          title: ads[index].itemTitle,
          rate: '100',
        );
      },
    );
  }

  Future<void> saveItem({required String id}) async {
    bool status = await SaveApiController().saveClassified(classifiedId: id);
    if (status) {
      ShowMySnakbar(
          title: 'تم العملية بنجاح',
          message: 'تم حفظ العنصر بنجاح',
          backgroundColor: Colors.green.shade700);
    } else {
      ShowMySnakbar(
          title: 'خطأ',
          message: 'حدث خطأ ما',
          backgroundColor: Colors.red.shade700);
    }
  }
}
