import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_controllers/profile_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/controller/image_picker_controller.dart';
import 'package:rakwa/screens/add_listing_screens/Widget/bottom_sheet_country.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/personal_screen.dart';
import 'package:rakwa/screens/personal_screens/Controllers/change_account_info_controller.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/widget/TextFields/text_field_default.dart';
import 'package:rakwa/widget/TextFields/validator.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/main_elevated_button.dart';
import 'package:rakwa/widget/my_text_field.dart';

import '../../controller/list_controller.dart';
import '../../model/country_model.dart';
import 'package:http/http.dart' as http;

class AccountInformationScreen extends StatefulWidget {
  const AccountInformationScreen({super.key});

  @override
  State<AccountInformationScreen> createState() =>
      _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen>
    with Helpers {
  dynamic countryName;
  int? countryID;

  dynamic selectedCountry;
  late TextEditingController _locationController;

  // var kGoogleApiKey = "AIzaSyBGOvwzbb9UAQ5K2ECo1Jtb5rH9N9YRaF8";
  var kGoogleApiKey = "AIzaSyBwFkLaLQpcmX-vrUhKhaRlqF5-ISeBa8E";

  ListController _listController = Get.put(ListController());
  ImagePickerController _imagePickerController =
      Get.put(ImagePickerController());

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    printDM("SharedPrefController().userPreferCountryId is => ${SharedPrefController()
        .userPreferCountryId}");
    ChangeAccountInfoController changeAccountInfoController =
        Get.put(ChangeAccountInfoController());
    var node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBars.appBarDefault(title: "تغير معلومات الحساب"),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          GetBuilder<ImagePickerController>(
            builder: (controller) {
              return InkWell(
                onTap: () {
                  _imagePickerController.getImageFromGallary();
                },
                borderRadius: BorderRadius.circular(777),
                child: _imagePickerController.image_file != null
                    ? Container(
                        height: 120,
                        width: 120,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(777),
                            child: Image.file(
                              File(
                                _imagePickerController.image_file!.path,
                              ),
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : SharedPrefController().image.isNotEmpty
                        ? Container(
                            height: 120,
                            width: 120,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(777),
                                child: Image.network(
                                  'https://www.rakwa.com/laravel_project/public/storage/user/${SharedPrefController().image}',
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: 120,
                            width: 120,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(777),
                                child: Image.asset(
                                  'images/defoultAvatar.png',
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
              );
            },
          ),
          GetBuilder<ChangeAccountInfoController>(
            builder: (_) => Form(
              key: _.globalKey,
              child: Column(
                children: [
                  TextFieldDefault(
                    upperTitle: 'الاسم الأول',
                    hint: 'ادخل الاسم الأول',
                    prefixIconSvg: "User",
                    // prefixIconData: Icons.person_outline,
                    controller: _.firstNameController,
                    keyboardType: TextInputType.name,
                    validation: firstNameValidator,
                    onComplete: () {
                      node.nextFocus();
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFieldDefault(
                    upperTitle: 'الاسم الأخير',
                    hint: 'ادخل الاسم الأخير',
                    prefixIconSvg: "User",
                    controller: _.lastNameController,
                    keyboardType: TextInputType.name,
                    validation: lastNameValidator,
                    onComplete: () {
                      node.nextFocus();
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFieldDefault(
                    upperTitle: 'البريد الالكتروني',
                    hint: 'ادخل البريد الالكتروني',
                    prefixIconSvg: "Email",
                    // prefixIconData: Icons.email_outlined,
                    controller: _.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validation: emailValidator,
                    onComplete: () {
                      node.nextFocus();
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFieldDefault(
                    upperTitle: "رقم الهاتف",
                    hint: 'ادخل رقم الهاتف',
                    prefixIconSvg: "TFPhone",
                    // prefixIconData: Icons.phone_outlined,
                    controller: _.phoneController,
                    keyboardType: TextInputType.phone,
                    validation: phoneValidator,
                    onComplete: () {
                      node.nextFocus();
                    },
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<ListController>(
                    builder: (controller) => GestureDetector(
                      onTap: () {
                        node.unfocus();
                        Get.bottomSheet(
                          BottomSheetCountry(
                            country: controller.countrys,
                            bottomSheetTitle: "الدول",
                            countrySelectedId: countryID !=null ? countryID!:
                                SharedPrefController()
                                    .userPreferCountryId!="null"?int.tryParse(SharedPrefController()
                                .userPreferCountryId) as int :
                                0,
                            onSelect: (country) {
                              setState(() {
                                selectedCountry = country;
                                _.countryController.text = country.countryName;
                                countryID = country.id;
                              });
                            },
                          ),
                        );
                      },
                      child: TextFieldDefault(
                        enable: false,
                        upperTitle: "الدولة",
                        hint: 'اختار الدولة',
                        prefixIconSvg: "country",
                        suffixIconData: Icons.arrow_drop_down_sharp,
                        controller: _.countryController,
                        validation: locationValidator,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          MainElevatedButton(
            height: 56,
            width: Get.width,
            borderRadius: 12,
            onPressed: () {
              node.unfocus();
              changeAccountInfoController.changeAccountInfo(
                countryId: countryID != null ? countryID.toString() : '399',
                file: _imagePickerController.image_file != null
                    ? File(_imagePickerController.image_file!.path)
                    : null,
              );
            },
            child: Text(
              'حفظ التغيرات',
              style: GoogleFonts.notoKufiArabic(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
