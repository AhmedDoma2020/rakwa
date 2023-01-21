import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_controllers/list_api_controller.dart';
import 'package:rakwa/controller/custom_field_getx_controller.dart';
import 'package:rakwa/model/create_item_model.dart';
import 'package:rakwa/screens/add_listing_screens/Controllers/add_work_controller.dart';
import 'package:rakwa/screens/add_listing_screens/add_custom_field_screen.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_subcategory_screen.dart';
import 'package:rakwa/screens/add_listing_screens/done_screen.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';
import 'package:rakwa/widget/TextFields/text_field_default.dart';
import 'package:rakwa/widget/TextFields/validator.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/my_text_field.dart';
import 'package:rakwa/widget/next_step_button.dart';

import '../../app_colors/app_colors.dart';
import '../../widget/steps_widget.dart';

class AddListSocialInformationScreen extends StatefulWidget {
  final bool isList;

  AddListSocialInformationScreen({required this.isList});

  @override
  State<AddListSocialInformationScreen> createState() =>
      _AddListSocialInformationScreenState();
}

//بضيفش لو مكتوبات
// اضافة تكست هيلبر
// اضافة مقدمة الدولة
// اضافة عمل بدل قائمة
// حدف اخر صفحة بالاضافة

class _AddListSocialInformationScreenState
    extends State<AddListSocialInformationScreen> with Helpers {
  GetCustomFieldController customFieldGetxController = Get.find();

  @override
  Widget build(BuildContext context) {
    printDM("1.checkBoxData.length is ${customFieldGetxController.checkBoxData.length}");

    AddWorkOrAdsController addWorkController =Get.find();
    var node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBars.appBarDefault(
          title: widget.isList ? 'إضافة عمل' : 'اضافة اعلان'),
      floatingActionButton: FloatingActionButtonNext(
        onTap: () async {
          if (customFieldGetxController.data != null) {
            Get.to(
              () => AddCustomFieldScreen(
                isList: widget.isList,
              ),
            );
          } else {
            addWorkController.addWork(checkBox: [],textFiled: []);
          }
        },
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            24.ESH(),
            StepsWidget(selectedStep: 5),
            32.ESH(),
            GetBuilder<AddWorkOrAdsController>(
              builder: (_) => ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  TextFieldDefault(
                    upperTitle: "رقم الهاتف",
                    hint: 'ادخل رقم الهاتف',
                    prefixIconSvg: "TFPhone",
                    controller: _.phoneController,
                    keyboardType: TextInputType.name,
                    onComplete: () {
                      node.nextFocus();
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFieldDefault(
                    upperTitle: "الموقع",
                    hint: 'الصق URL الموقع الخاص بك هنا',
                    prefixIconPng: "Link",
                    controller: _.websiteController,
                    keyboardType: TextInputType.emailAddress,
                    validation: urlValidator,
                    onComplete: () {
                      node.nextFocus();
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFieldDefault(
                    upperTitle: "فيس بوك",
                    hint: 'الصق URL الفيس بوك الخاص بك هنا',
                    prefixIconPng: "Facebook",
                    controller: _.facebookController,
                    keyboardType: TextInputType.emailAddress,
                    validation: urlValidator,
                    onComplete: () {
                      node.nextFocus();
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFieldDefault(
                    upperTitle: "تويتر",
                    hint: 'الصق URL التويتر الخاص بك هنا',
                    prefixIconPng: "Twitter",
                    controller: _.twitterController,
                    keyboardType: TextInputType.emailAddress,
                    validation: urlValidator,
                    onComplete: () {
                      node.nextFocus();
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFieldDefault(
                    upperTitle: "الانستغرام",
                    hint: 'الصق URL الانستغرام الخاص بك هنا',
                    prefixIconPng: "Instagram",
                    controller: _.instagramController,
                    keyboardType: TextInputType.emailAddress,
                    validation: urlValidator,
                    onComplete: () {
                      node.nextFocus();
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFieldDefault(
                    upperTitle: "لينكد ان",
                    hint: 'الصق URL اللينكد ان الخاص بك هنا',
                    prefixIconPng: "LinkedIn",
                    controller: _.linkedInController,
                    keyboardType: TextInputType.emailAddress,
                    validation: urlValidator,
                    onComplete: () {
                      node.nextFocus();
                    },
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(
                    height: 26,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// CreateItemModel get createItemModel {
//   CreateItemModel createItemModel = widget.createItemModel;
//   createItemModel.itemSocialFacebook = _facebookController.text;
//   createItemModel.itemSocialInstagram = _instagramController.text;
//   createItemModel.itemSocialLinkedin = _linkedInController.text;
//   createItemModel.itemSocialTwitter = _twitterController.text;
//   createItemModel.itemSocialWhatsapp = _phoneController.text;
//   createItemModel.itemPhone = _phoneController.text;
//   createItemModel.itemWebsite = _websiteController.text;
//   createItemModel.itemYoutubeId = _websiteController.text;
//
//   return createItemModel;
// }
}
