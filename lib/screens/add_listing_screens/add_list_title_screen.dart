import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/controller/custom_field_getx_controller.dart';
import 'package:rakwa/model/create_item_model.dart';
import 'package:rakwa/screens/add_listing_screens/Controllers/add_work_controller.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_address_screen.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_subcategory_screen.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/widget/TextFields/text_field_default.dart';
import 'package:rakwa/widget/TextFields/validator.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/main_elevated_button.dart';
import 'package:rakwa/widget/my_text_field.dart';
import 'package:steps_indicator/steps_indicator.dart';

import '../../widget/next_step_button.dart';
import '../../widget/steps_widget.dart';

class AddListTitleScreen extends StatelessWidget {
  // final CreateItemModel createItemModel;
  final bool isList;

   AddListTitleScreen({super.key, required this.isList});

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);
    AddWorkOrAdsController addWordController = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBars.appBarDefault(
          title: isList ? 'إضافة عمل' : 'اضافة اعلان'),
      floatingActionButton: FloatingActionButtonNext(
        onTap: () {
          addWordController.navigationAfterAddJopTitleAndDescription(globalKey);
        },
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          StepsWidget(selectedStep: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: globalKey,
              child: GetBuilder<AddWorkOrAdsController>(
                builder:(_) =>  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    TextFieldDefault(
                      upperTitle: "عنوان القائمة",
                      hint: 'ادخل عنوان الرسالة',
                      prefixIconSvg: "address",
                      // prefixIconData: Icons.email_outlined,
                      controller: _.titleController,

                      keyboardType: TextInputType.name,
                      validation: addressMenuValidator,
                      onComplete: () {
                        node.nextFocus();
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFieldDefault(
                      upperTitle: "الوصف",
                      hint: 'ادخل الوصف',
                      // prefixIconUrl: "Email",
                      // prefixIconData: Icons.email_outlined,
                      controller: _.descriptionController,
                      keyboardType: TextInputType.name,
                      validation: descriptionValidator,
                      maxLines: 5,
                      onComplete: () {
                        node.unfocus();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // CreateItemModel get createItemModel {
  //   CreateItemModel createItemModel = widget.createItemModel;
  //   createItemModel.itemTitle = _titleController.text;
  //   createItemModel.itemDescription = _describtionController.text;
  //   return createItemModel;
  // }
}
