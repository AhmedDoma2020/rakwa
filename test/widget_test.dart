import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/api/api_controllers/list_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/controller/custom_field_getx_controller.dart';
import 'package:rakwa/model/create_item_model.dart';
import 'package:rakwa/model/custom_field_model.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_subcategory_screen.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_title_screen.dart';
import 'package:rakwa/screens/add_listing_screens/done_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';
import 'package:rakwa/widget/TextFields/text_field_default.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/main_elevated_button.dart';
import 'package:rakwa/widget/my_text_field.dart';
import 'package:rakwa/widget/next_step_button.dart';
import 'package:rakwa/widget/steps_widget.dart';

// List allTextData = [];
// List allTextDataWithId = [];
// List checkBoxData = [];
// List checkBoxDataValue = [];
// List checkBoxDataValueWithId = [];
// CustomFieldModel? data;
// List<String> customFields = [];
// List checkBoxDataSub = [];
GetCustomFieldController customFieldGetxController = Get.find();

class AddCustomFieldScreen extends StatefulWidget {
  final List<String> ids;
  final CreateItemModel createItemModel;
  final bool isList;

  AddCustomFieldScreen(
      {required this.ids, required this.createItemModel, required this.isList});

  @override
  State<AddCustomFieldScreen> createState() => _AddCustomFieldScreenState();
}

class _AddCustomFieldScreenState extends State<AddCustomFieldScreen> {
  bool clicked = false;
  bool visible = true;

  // void splitData() {
  //   for (int o = 0; o <= checkBoxData.length - 1; o++) {
  //     final split = checkBoxData[o].customFieldSeedValue.split(',');
  //     for (int i = 0; i <= split.length - 1; i++) {
  //       checkBoxDataSub.add([split[i], false]);
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // getCustom();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // getCustom() async {
  //   data = await ListApiController().getCustomFields(
  //       ids: widget.createItemModel.category, isList: widget.isList);
  //   customFields.addAll(data!.customFields!);
  //   print('$customFields +=========+++++++++++++====================');
  //   print('$data +=========+++++++++++++====================');
  //   for (int i = 0; i <= data!.data!.length - 1; i++) {
  //     TextEditingController textEditingController = TextEditingController();

  //     if (data!.data![i].customFieldSeedValue == null) {
  //       allTextData.add([textEditingController, data!.data![i]]);
  //     } else {
  //       checkBoxData.add(data!.data![i]);
  //     }
  //   }
  //   // splitData();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButtonNext(
        onTap: () async {
          if (visible) {
            setState(() {
              visible = false;
            });
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
            print(customFieldGetxController.checkBoxDataValueWithId);

            // if (showTextField) {
            //   setState(() {
            //     showTextField = false;
            //   });
            // } else {

            // bool status = await ListApiController().addList(
            //     checkBox: customFieldGetxController.checkBoxDataValueWithId,
            //     textFiled: customFieldGetxController.allTextDataWithId,
            //     createItemModel: widget.createItemModel,
            //     keysCustomFields: customFieldGetxController.keysCustomFields,
            //     isList: widget.isList,
            //   id: SharedPrefController().id,
            // );
            // if (status) {
            //   customFieldGetxController.allTextData = [];
            //   customFieldGetxController.allTextDataWithId = [];
            //   customFieldGetxController.checkBoxDataValue = [];
            //   customFieldGetxController.checkBoxData = [];
            //   customFieldGetxController.keysCustomFields = [];
            //   customFieldGetxController.checkBoxDataValueWithId = [];
            //   Get.offAll(() => DoneScreen(
            //     isList: widget.isList,
            //   ));
            // } else {
            //   setState(() {
            //     clicked = !clicked;
            //   });
            // }
            // }
            // Get.to(() => AddListTitleScreen(
            //       createItemModel: widget.createItemModel,
            //       isList: true,
            //     ));

            // print(checkBoxDataValue);
            //  print(checkBoxData);
          }
        },
      ),
      appBar: AppBars.appBarDefault(title: "العناصر المخصصة"),
      body: ListView(
        children: [
          const SizedBox(
            height: 24,
          ),
          StepsWidget(selectedStep: 6),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Visibility(
              visible: visible,
              replacement: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 50, child: Divider());
                },
                itemCount: customFieldGetxController.checkBoxData.length,
                itemBuilder: (context, index) {
                  return
                    TextFieldDefault(
                      upperTitle: customFieldGetxController
                          .checkBoxData[index].customFieldName!,
                      hint: 'ادخل هنا',
                      
                      controller: customFieldGetxController.checkBoxData[index],
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                    );
                  //   Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       customFieldGetxController
                  //           .checkBoxData[index].customFieldName!,
                  //       style: GoogleFonts.notoKufiArabic(
                  //           textStyle: const TextStyle(
                  //               fontSize: 16, fontWeight: FontWeight.w500)),
                  //     ),
                  //     const SizedBox(
                  //       height: 15,
                  //     ),
                  //     MultiSeedWidget(
                  //         customFieldSeedValue:
                  //             customFieldGetxController.checkBoxData[index])
                  //   ],
                  // );
                },
              ),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16, child: Divider(color: Colors.white,thickness: 4,));
                },
                itemCount: customFieldGetxController.allTextData.length,
                itemBuilder: (context, index) {
                  return
                    TextFieldDefault(
                      upperTitle: customFieldGetxController
                          .allTextData[index][1].customFieldName!,
                      hint: 'ادخل هنا',
                      
                      controller: customFieldGetxController.allTextData[index][0],
                      keyboardType: TextInputType.multiline,
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
        ],
      ),
    );
  }

// CreateItemModel get createItemModel{
//   CreateItemModel createItemModel = widget.createItemModel;
//   createItemModel.wifi3

//   return createItemModel;
// }

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

  @override
  void initState() {
    super.initState();
    splitData();
    // print(checkBoxDataSub);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) {
          return const VerticalDivider(
            endIndent: 10,
            indent: 10,
          );
        },
        physics: const BouncingScrollPhysics(),
        itemCount: checkBoxDataSub.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Text(checkBoxDataSub[index][0].toString()),
              Checkbox(
                activeColor: AppColors.mainColor,
                value: customFieldGetxController.checkBoxDataValue
                    .contains(checkBoxDataSub[index][0]),
                onChanged: (value) {
                  if (value == true) {
                    customFieldGetxController.checkBoxDataValue
                        .add(checkBoxDataSub[index][0]);
                    customFieldGetxController.checkBoxDataValueWithId.add([
                      checkBoxDataSub[index][0],
                      widget.customFieldSeedValue.categoryId,
                      widget.customFieldSeedValue.customFieldName,
                    ]);
                  } else {
                    customFieldGetxController.checkBoxDataValue
                        .remove(checkBoxDataSub[index][0]);
                    customFieldGetxController.checkBoxDataValueWithId
                        .removeWhere((element) =>
                    element[0] == checkBoxDataSub[index][0] &&
                        element[1] == widget.customFieldSeedValue.categoryId &&
                        element[2] ==
                            widget.customFieldSeedValue.customFieldName);
                    // checkBoxDataValueWithId.remove([
                    //   widget.customFieldSeedValue.id,
                    //   checkBoxDataSub[index][0]
                    // ]);

                    // var itemIndex =  checkBoxDataValueWithId.indexOf([checkBoxDataSub[index][0],widget.customFieldSeedValue.id]);
                    // checkBoxDataValueWithId.removeAt(itemIndex);
                    //                   if(checkBoxDataValueWithId.contains([
                    //                     checkBoxDataSub[index][0],
                    //                     widget.customFieldSeedValue.id
                    //                   ])){
                    //  checkBoxDataValueWithId.remove([
                    //                     checkBoxDataSub[index][0],
                    //                     widget.customFieldSeedValue.id
                    //                   ]);
                    //                     print('object22222222222222222222222222');

                    //                   }else{
                    //                     print('object');
                    //                   }

                  }
                  setState(() {
                    checkBoxDataSub[index][1] = value;
                  });
                },
              )
            ],
          );
        },
      ),
    );
  }
}
