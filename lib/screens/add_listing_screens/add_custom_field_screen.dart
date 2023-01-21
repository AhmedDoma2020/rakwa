import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_controllers/list_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/controller/custom_field_getx_controller.dart';
import 'package:rakwa/model/create_item_model.dart';
import 'package:rakwa/model/custom_field_model.dart';
import 'package:rakwa/screens/add_listing_screens/Controllers/add_work_controller.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_subcategory_screen.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_title_screen.dart';
import 'package:rakwa/screens/add_listing_screens/done_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';
import 'package:rakwa/widget/ButtomSheets/row_select_item.dart';
import 'package:rakwa/widget/TextFields/text_field_default.dart';
import 'package:rakwa/widget/TextFields/validator.dart';
import 'package:rakwa/widget/main_elevated_button.dart';
import 'package:rakwa/widget/my_text_field.dart';
import 'package:rakwa/widget/next_step_button.dart';
import 'package:rakwa/widget/steps_widget.dart';


class AddCustomFieldScreen extends StatefulWidget {
  final bool isList;

  const AddCustomFieldScreen({super.key, required this.isList});

  @override
  State<AddCustomFieldScreen> createState() => _AddCustomFieldScreenState();
}

class _AddCustomFieldScreenState extends State<AddCustomFieldScreen> {
  bool clicked = false;
  bool visible = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  GetCustomFieldController customFieldGetxController = Get.find();

  @override
  Widget build(BuildContext context){
  printDM("visible is $visible");
  printDM("customFieldGetxController.checkBoxData.length is ${customFieldGetxController.checkBoxData.length}");
  AddWorkOrAdsController addWorkController = Get.find();

    return Scaffold(
      floatingActionButton: FloatingActionButtonNext(
        onTap: () async {

            if (visible) {
              // if (globalKey.currentState!.validate()) {
              //   globalKey.currentState!.save();
                setState(() {
                  visible = false;
                });
              // }
            } else {
              clicked = !clicked;
              for (int i = 0;
              i <= customFieldGetxController.allTextData.length - 1;
              i++) {
                customFieldGetxController.allTextDataWithId.add([
                  customFieldGetxController.allTextData[i][0].text,
                  customFieldGetxController.allTextData[i][1].categoryId,
                  customFieldGetxController.allTextData[i][1].customFieldName
                ]);
              }
              print(customFieldGetxController.allTextDataWithId);
              printDM(
                  "customFieldGetxController.checkBoxDataValueWithId is => ${customFieldGetxController.checkBoxDataValueWithId}");
              bool status = await addWorkController.addWork(
                checkBox: customFieldGetxController.checkBoxDataValueWithId,
                textFiled: customFieldGetxController.allTextDataWithId,
              );
              if (!status) {
                setState(() {
                  clicked = !clicked;
                });
              }
            }


        },
      ),
      appBar: AppBar(
        title: Text(
          'العناصر المخصصة',
          style: GoogleFonts.notoKufiArabic(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        // physics: NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(
            height: 24,
          ),
          StepsWidget(selectedStep: 6),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Visibility(
              visible: visible,
              replacement: Padding(
                padding: const EdgeInsets.only(bottom: 48.0),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 50, child: Divider());
                  },
                  itemCount: customFieldGetxController.checkBoxData.length,
                  itemBuilder: (context, index) {
                    printDM("visible 2 is $visible");

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customFieldGetxController
                              .checkBoxData[index].customFieldName!,
                          style: GoogleFonts.notoKufiArabic(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MultiSeedWidget(
                            customFieldSeedValue:
                                customFieldGetxController.checkBoxData[index])
                      ],
                    );
                  },
                ),
              ),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const SizedBox(
                      height: 16,
                      child: Divider(
                        color: Colors.white,
                        thickness: 4,
                      ));
                },
                itemCount: customFieldGetxController.allTextData.length,
                itemBuilder: (context, index) {
                  bool isUrlField = customFieldGetxController
                      .allTextData[index][1].customFieldType=="4";
                  return TextFieldDefault(
                    upperTitle: customFieldGetxController
                        .allTextData[index][1].customFieldName!,
                    hint: isUrlField? "https://www.rakwa.com/":'ادخل هنا',
                    controller: customFieldGetxController.allTextData[index][0],
                    keyboardType: isUrlField? TextInputType.emailAddress
                        :TextInputType.multiline,
                    validation: isUrlField?urlValidator:null,
                    maxLines: 5,
                  );
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       customFieldGetxController
                  //           .allTextData[index][1].customFieldName!,
                  //       style: GoogleFonts.notoKufiArabic(
                  //           textStyle: const TextStyle(
                  //               fontSize: 16, fontWeight: FontWeight.w500)),
                  //     ),
                  //     const SizedBox(
                  //       height: 15,
                  //     ),
                  //     SingleSeedWidget(
                  //       textEditingController:
                  //       customFieldGetxController.allTextData[index][0],
                  //     )
                  //   ],
                  // );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}

class SingleSeedWidget extends StatefulWidget {
  final TextEditingController textEditingController;

  SingleSeedWidget({required this.textEditingController});

  @override
  State<SingleSeedWidget> createState() => _SingleSeedWidgetState();
}

class _SingleSeedWidgetState extends State<SingleSeedWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
          hint: 'اكتب هنا',
          helperText: 'https://www.rakwa.com/',
          controller: widget.textEditingController,
          onChanged: (p0) {},
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

class MultiSeedWidget extends StatefulWidget {
  final dynamic customFieldSeedValue;

  MultiSeedWidget({
    required this.customFieldSeedValue,
  });

  @override
  State<MultiSeedWidget> createState() => _MultiSeedWidgetState();
}

class _MultiSeedWidgetState extends State<MultiSeedWidget> {
  List checkBoxDataSub = [];

  void splitData() {
    print('==================================');

    final split = widget.customFieldSeedValue.customFieldSeedValue.split(',');
    for (int i = 0; i <= split.length - 1; i++) {
      checkBoxDataSub.add([split[i], false]);
    }
  }
  GetCustomFieldController customFieldGetxController = Get.find();

  @override
  void initState() {
    super.initState();
    splitData();
    // print(checkBoxDataSub);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) {
          return const VerticalDivider(
            endIndent: 10,
            indent: 10,
            color: AppColors.mainColor,
          );
        },
        physics: const BouncingScrollPhysics(),
        itemCount: checkBoxDataSub.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Text(
                checkBoxDataSub[index][0].toString(),
                style: GoogleFonts.notoKufiArabic(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    child: SingleChoiceWidget(
                      active: customFieldGetxController.checkBoxDataValue
                          .contains(checkBoxDataSub[index][0]),
                    ),
                  ),
                  Theme(
                    data: ThemeData(
                      // primarySwatch: Colors.transparent,
                      unselectedWidgetColor: Colors.transparent, // Your color
                    ),
                    child: Checkbox(
                      activeColor: Colors.transparent,
                      side: BorderSide.none,
                      checkColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      // overlayColor: ,
                      value: customFieldGetxController.checkBoxDataValue
                          .contains(checkBoxDataSub[index][0]),
                      onChanged: (value) {
                        if (value == true) {
                          customFieldGetxController.checkBoxDataValue
                              .add(checkBoxDataSub[index][0]);
                          customFieldGetxController.checkBoxDataValueWithId
                              .add([
                            checkBoxDataSub[index][0],
                            widget.customFieldSeedValue.categoryId,
                            widget.customFieldSeedValue.customFieldName,
                          ]);
                        } else {
                          customFieldGetxController.checkBoxDataValue
                              .remove(checkBoxDataSub[index][0]);
                          customFieldGetxController.checkBoxDataValueWithId
                              .removeWhere(
                            (element) =>
                                element[0] == checkBoxDataSub[index][0] &&
                                element[1] == widget.customFieldSeedValue.categoryId &&
                                element[2] ==
                                    widget.customFieldSeedValue.customFieldName,
                          );
                        }
                        setState(() {
                          checkBoxDataSub[index][1] = value;
                        });
                      },
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
