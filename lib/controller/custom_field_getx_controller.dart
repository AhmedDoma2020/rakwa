import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_controllers/list_api_controller.dart';
import 'package:rakwa/model/custom_field_model.dart';

class GetCustomFieldController extends GetxController {
  CustomFieldModel? data;
  List<String> keysCustomFields = [];
  List allTextData = [];
  List checkBoxData = [];
  List checkBoxDataValueWithId = [];
  List checkBoxDataValue = [];
  List allTextDataWithId = [];

  getCustom({required bool isList, required List<int> categoryIds}) async {
    data = await ListApiController()
        .getCustomFields(ids: categoryIds, isList: isList);
    if (data != null) {
      keysCustomFields.addAll(data!.keysCustomFields!);

      for (int i = 0; i <= data!.data!.length - 1; i++) {
        TextEditingController textEditingController = TextEditingController();

        if (data!.data![i].customFieldSeedValue == null) {
          allTextData.add([textEditingController, data!.data![i]]);
        } else {
          checkBoxData.add(data!.data![i]);
        }
      }
    }
printDM("checkBoxData is ${checkBoxData}");
  }

  void refreshData(){
   allTextData = [];
   allTextDataWithId = [];
   checkBoxDataValue = [];
   checkBoxData = [];
   keysCustomFields = [];
   checkBoxDataValueWithId = [];
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
