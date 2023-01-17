import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/controller/image_picker_controller.dart';
import 'package:rakwa/model/create_item_model.dart';
import 'package:rakwa/screens/add_listing_screens/Controllers/add_work_controller.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_social_information_screen.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_subcategory_screen.dart';
import 'package:rakwa/screens/claims_screens/create_claims_screen.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/next_step_button.dart';

import '../../app_colors/app_colors.dart';
import '../../widget/steps_widget.dart';

class AddListImagesScreen extends StatelessWidget {
  final bool isList;

   AddListImagesScreen({super.key, required this.isList});


  final ImagePickerController _imagePickerController =
      Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    AddWorkController addWordController = Get.find();
    return Scaffold(
      appBar: AppBars.appBarDefault(
          title: isList ? 'إضافة عمل' : 'اضافة اعلان'),
      floatingActionButton: FloatingActionButtonNext(onTap: () {
        if (checkData()) {
          if (_imagePickerController.images != null &&
              _imagePickerController.images!.isNotEmpty) {
            addWordController.imageGallery.clear();
            for (int i = 0; i < _imagePickerController.images!.length; i++) {
              var path = _imagePickerController.images![i].path;
              _imagePickerController.urls.add(path);
            }
            addWordController.imageGallery = _imagePickerController.urls;
          }
          addWordController.featureImage = _imagePickerController.image_file!.path;
          addWordController.navigationAfterAddImages();

        }
      }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          StepsWidget(selectedStep: 4),
          const SizedBox(
            height: 32,
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GetBuilder<ImagePickerController>(
              init: ImagePickerController(),
              builder: (controller) {
                return UploadImageWidget(
                  onTap: () => _imagePickerController.getImageFromGallary(),
                  isUploaded: _imagePickerController.image_file == null,
                  image: File(_imagePickerController.image_file != null
                      ? _imagePickerController.image_file!.path
                      : ""),
                );
              },
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GetBuilder<ImagePickerController>(
              init: ImagePickerController(),
              builder: (controller) {
                return UploadImagesWidget(
                  onTap: () => _imagePickerController.getMultiImage(),
                  isUploaded: _imagePickerController.images == null,
                  image: _imagePickerController.images != null
                      ? _imagePickerController.images!
                      : [],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool checkData() {
    if (_imagePickerController.image_file != null) {
      return true;
    }
    ShowMySnakbar(
        title: 'لم تقم باختيار صورة رئيسية',
        message: ' يجب عليك اختيار صورة رئيسية ',
        backgroundColor: Colors.red.shade700);
    return false;
  }

// CreateItemModel get createItemModel {
//   CreateItemModel createItemModel = widget.createItemModel;
//   if (_imagePickerController.images != null &&
//       _imagePickerController.images!.isNotEmpty) {
//     for (int i = 0; i < _imagePickerController.images!.length; i++) {
//       var path = _imagePickerController.images![i].path;
//       _imagePickerController.urls.add(path);
//     }
//     createItemModel.imageGallery = _imagePickerController.urls;
//   }
//
//   createItemModel.featureImage = _imagePickerController.image_file!.path;
//
//   return createItemModel;
// }
}
