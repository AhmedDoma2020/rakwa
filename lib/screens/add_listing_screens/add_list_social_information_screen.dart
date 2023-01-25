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
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

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
          if(_globalKey.currentState!.validate()){
            _globalKey.currentState!.save();
            if (customFieldGetxController.data != null) {
              Get.to(
                    () => AddCustomFieldScreen(
                  isList: widget.isList,
                ),
              );
            } else {
              addWorkController.addWork(checkBox: [],textFiled: []);
            }
          }

        },
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _globalKey,
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
                      validation: phoneValidator,
                      onComplete: () {
                        node.nextFocus();
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFieldDefault(
                      upperTitle: "الموقع",
                      hint: 'https://www.website.com',
                      prefixIconPng: "Link",
                      controller: _.websiteController,
                      keyboardType: TextInputType.url,
                      validation: urlValidator,
                      onComplete: () {
                        node.nextFocus();
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFieldDefault(
                      upperTitle: "فيس بوك",
                      hint: 'https://www.facebook.com',
                      prefixIconPng: "Facebook",
                      controller: _.facebookController,
                      keyboardType: TextInputType.url,
                      validation: urlValidator,
                      onComplete: () {
                        node.nextFocus();
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFieldDefault(
                      upperTitle: "تويتر",
                      hint: 'https://www.twitter.com',
                      prefixIconPng: "Twitter",
                      controller: _.twitterController,
                      keyboardType: TextInputType.url,
                      validation: urlValidator,
                      onComplete: () {
                        node.nextFocus();
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFieldDefault(
                      upperTitle: "الانستغرام",
                      hint: 'https://www.instgram.com',
                      prefixIconPng: "Instagram",
                      controller: _.instagramController,
                      keyboardType: TextInputType.url,
                      validation: urlValidator,
                      onComplete: () {
                        node.nextFocus();
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFieldDefault(
                      upperTitle: "لينكد ان",
                      hint: 'https://www.linkedIn.com',
                      prefixIconPng: "LinkedIn",
                      controller: _.linkedInController,
                      keyboardType: TextInputType.url,
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
