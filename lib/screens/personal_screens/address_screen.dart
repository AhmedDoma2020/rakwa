import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app_colors/app_colors.dart';
import '../../shared_preferences/shared_preferences.dart';
import '../../widget/main_elevated_button.dart';
import '../../widget/my_text_field.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late TextEditingController _streetController;
  late TextEditingController _contryController;
  late TextEditingController _cityController;

  @override
  void initState() {
    super.initState();
    _streetController = TextEditingController();
    _contryController = TextEditingController();
    _cityController = TextEditingController();
  }

  @override
  void dispose() {
    _streetController.dispose();
    _contryController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme:const IconThemeData(
          color: Colors.black
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 24,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'العنوان',
              style: GoogleFonts.notoKufiArabic(
                  textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
             'تحديث المعلومات الخاصة بك للحفاظ على حسابك',
              style: GoogleFonts.notoKufiArabic(
                  textStyle: const TextStyle(
                      fontSize: 14, color: AppColors.viewAllColor)),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
             'الشارع',
              style: GoogleFonts.notoKufiArabic(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.viewAllColor)),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          MyTextField(
              hint: 'شارع احمد بن عبد العزيز', controller: _streetController),
               const SizedBox(
            height: 24,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
             'الدولة',
              style: GoogleFonts.notoKufiArabic(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.viewAllColor)),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          MyTextField(
              hint: 'تركيا', controller: _contryController),
               const SizedBox(
            height: 24,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'المدينة',
              style: GoogleFonts.notoKufiArabic(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.viewAllColor)),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          MyTextField(hint: 'إسطنبول', controller: _cityController),
          const SizedBox(
            height: 32,
          ),
          MainElevatedButton(
            height: 56,
            width: Get.width,
            borderRadius: 12,
            onPressed: () {},
            child: Text('حفظ التغيرات',style: GoogleFonts.notoKufiArabic(
              textStyle:const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white
              )
            ),),
          )
        ],
      ),
    );
  }
}