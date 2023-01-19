import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/model/create_item_model.dart';
import 'package:rakwa/screens/add_listing_screens/Controllers/add_work_controller.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_images_screen.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_subcategory_screen.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/widget/TextFields/text_field_default.dart';
import 'package:rakwa/widget/TextFields/validator.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/label_text.dart';
import 'package:rakwa/widget/my_text_field.dart';

import '../../widget/next_step_button.dart';
import '../../widget/steps_widget.dart';
import '../../widget/work_hour_widget.dart';

class AddListWorkDaysScreen extends StatefulWidget {
  // final CreateItemModel createItemModel;
  final bool isList;

  const AddListWorkDaysScreen({super.key,  required this.isList});

  @override
  State<AddListWorkDaysScreen> createState() => _AddListWorkDaysScreenState();
}

class _AddListWorkDaysScreenState extends State<AddListWorkDaysScreen>
    with Helpers {

  List days = [
    [
      'السبت',
      false,
      TimeOfDay(hour: 6, minute: 30),
      TimeOfDay(hour: 16, minute: 30),
      '6'
    ],
    [
      'الاحد',
      false,
      TimeOfDay(hour: 6, minute: 30),
      TimeOfDay(hour: 16, minute: 30),
      '7'
    ],
    [
      'الاثنين',
      false,
      TimeOfDay(hour: 6, minute: 30),
      TimeOfDay(hour: 16, minute: 30),
      '1'
    ],
    [
      'الثلاثاء',
      false,
      TimeOfDay(hour: 6, minute: 30),
      TimeOfDay(hour: 16, minute: 30),
      '2'
    ],
    [
      'الاربعاء',
      false,
      TimeOfDay(hour: 6, minute: 30),
      TimeOfDay(hour: 16, minute: 30),
      '3'
    ],
    [
      'الخميس',
      false,
      TimeOfDay(hour: 6, minute: 30),
      TimeOfDay(hour: 16, minute: 30),
      '4'
    ],
    [
      'الجمعة',
      false,
      TimeOfDay(hour: 6, minute: 30),
      TimeOfDay(hour: 16, minute: 30),
      '5'
    ],
  ];

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AddWorkOrAdsController addWorkController = Get.find();
    var node = FocusScope.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBars.appBarDefault(
          title: widget.isList ? 'إضافة عمل' : 'اضافة اعلان'),
      floatingActionButton: FloatingActionButtonNext(
        onTap: () {
          if(addWorkController.itemHours.isNotEmpty){
            addWorkController.itemHours.clear();
          }
          if (widget.isList) {
            final localizations = MaterialLocalizations.of(context);
            for (var i = 0; i < days.length; i++) {
              if (days[i][1] == true) {
                final start = localizations.formatTimeOfDay(days[i][2],
                    alwaysUse24HourFormat: true);
                final end = localizations.formatTimeOfDay(days[i][3],
                    alwaysUse24HourFormat: true);
                addWorkController.itemHours.add('${days[i][4]} $start $end');
                // createItemModel.itemHours.add('${days[i][4]} $start $end');
              }
            }
          } else {
            // createItemModel.price = _priceController.text;
          }
          addWorkController.navigationAfterAddWorkDay(globalKey);
        },
      ),
      body: widget.isList
          ? Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                StepsWidget(selectedStep: 3),
                const SizedBox(
                  height: 32,
                ),
                Expanded(
                    child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    return WorkHourWidget(
                      amChild: Text(
                        'من ${days[index][2].hour}:${days[index][2].minute}',
                        style: GoogleFonts.notoKufiArabic(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      pmChild: Text(
                        'الى ${days[index][3].hour}:${days[index][3].minute}',
                        style: GoogleFonts.notoKufiArabic(
                            textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        )),
                      ),
                      onTapAm: () async {
                        TimeOfDay? newTime = await showTimePicker(
                          context: context,
                          initialTime: days[index][2],
                          cancelText: 'الغاء',
                          confirmText: 'تم',
                          builder: (context, child) {
                            return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: const ColorScheme.light(
                                    // change the border color
                                    primary: AppColors.mainColor,
                                    // change the text color
                                    onSurface: Colors.black,
                                  ),
                                  // button colors
                                  buttonTheme: const ButtonThemeData(
                                    colorScheme: ColorScheme.light(
                                      primary: AppColors.mainColor,
                                    ),
                                  ),
                                ),
                                child: child!);
                          },
                        );
                        if (newTime != null) {
                          setState(() {
                            days[index][2] = newTime;
                          });
                        }
                      },
                      onTapPm: () async {
                        TimeOfDay? newTime = await showTimePicker(
                          context: context,
                          initialTime: days[index][3],
                          cancelText: 'الغاء',
                          confirmText: 'تم',
                          builder: (context, child) {
                            return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: const ColorScheme.light(
                                    // change the border color
                                    primary: AppColors.mainColor,
                                    // change the text color
                                    onSurface: Colors.black,
                                  ),
                                  // button colors
                                  buttonTheme: const ButtonThemeData(
                                    colorScheme: ColorScheme.light(
                                      primary: AppColors.mainColor,
                                    ),
                                  ),
                                ),
                                child: child!);
                          },
                        );
                        if (newTime != null) {
                          setState(() {
                            days[index][3] = newTime;
                          });
                        }
                      },
                      day: days[index][0],
                      isChecked: days[index][1],
                      onChanged: (p0) {
                        setState(() {
                          days[index][1] = !days[index][1];
                        });
                      },
                    );
                  },
                )),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    GetBuilder<AddWorkOrAdsController>(
                      builder:(_) =>  TextFieldDefault(
                        upperTitle: "السعر",
                        hint: 'ادخل السعر',
                        controller: _.priceController,

                        // prefixIconData: Icons.lock_outline,
                        validation: priceValidator,
                        onComplete: () {
                          node.unfocus();
                        },
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
  //
  //   if (widget.isList) {
  //     final localizations = MaterialLocalizations.of(context);
  //     for (var i = 0; i < days.length; i++) {
  //       if (days[i][1] == true) {
  //         final start = localizations.formatTimeOfDay(days[i][2],
  //             alwaysUse24HourFormat: true);
  //         final end = localizations.formatTimeOfDay(days[i][3],
  //             alwaysUse24HourFormat: true);
  //         print(start);
  //         print(end);
  //
  //         createItemModel.itemHours.add('${days[i][4]} $start $end');
  //       }
  //     }
  //     print(createItemModel.itemHours);
  //   } else {
  //     createItemModel.price = _priceController.text;
  //   }
  //
  //   return createItemModel;
  // }
}