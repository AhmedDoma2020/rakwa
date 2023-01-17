import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rakwa/api/api_controllers/claims_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/controller/image_picker_controller.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/widget/TextFields/text_field_default.dart';
import 'package:rakwa/widget/TextFields/validator.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/main_elevated_button.dart';
import 'package:rakwa/widget/my_text_field.dart';

class CreateClaimsScreen extends StatefulWidget {
  final String id;

  CreateClaimsScreen({required this.id});

  @override
  State<CreateClaimsScreen> createState() => _CreateClaimsScreenState();
}

class _CreateClaimsScreenState extends State<CreateClaimsScreen> with Helpers {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _proofController;
  ImagePickerController _imagePickerController =
      Get.put(ImagePickerController());

  bool clicked = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _proofController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _proofController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBars.appBarDefault(title: "المطالبة بإدارة العمل"),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(
            height: 24,
          ),
          GetBuilder<ImagePickerController>(
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
          const SizedBox(
            height: 16,
          ),
          TextFieldDefault(
            upperTitle: 'الاسم الشخصي',
            hint: 'ادخل الاسم الشخصي',
            prefixIconSvg: "User",
            // prefixIconData: Icons.person_outline,
            controller: _nameController,
            keyboardType: TextInputType.name,
            validation: personalNameValidator,
            onComplete: () {
              node.nextFocus();
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFieldDefault(
            upperTitle: 'الايميل الشخصي',
            hint: 'ادخل الايميل الشخصي',
            prefixIconSvg: "Email",
            // prefixIconData: Icons.email_outlined,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validation: emailValidator,
            onComplete: () {
              node.nextFocus();
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFieldDefault(
            upperTitle: "رقم الهاتف",
            hint: 'ادخل رقم الهاتف',
            prefixIconSvg: "TFPhone",
            // prefixIconData: Icons.phone_outlined,
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            validation: phoneValidator,
            onComplete: () {
              node.nextFocus();
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFieldDefault(
            upperTitle: "الدليل",
            hint: 'ادخل الدليل',
            // prefixIconData: Icons.phone_outlined,
            prefixIconSvg: "TFNote",

            controller: _proofController,
            keyboardType: TextInputType.phone,
            validation: phoneValidator,
            onComplete: () {
              node.nextFocus();
            },
          ),
          const SizedBox(
            height: 32,
          ),
          MainElevatedButton(
            height: 56,
            width: Get.width,
            borderRadius: 12,
            onPressed: () async {
              bool status = await ClaimsApiController().createClaims(
                  image: _imagePickerController.image_file!.path,
                  id: widget.id,
                  name: _nameController.text,
                  phone: _phoneController.text,
                  email: _emailController.text,
                  proof: _proofController.text);
              if (status) {
                ShowMySnakbar(
                    title: 'تمت العملية بنجاح',
                    message: 'تم ارسال طلبك',
                    backgroundColor: Colors.green.shade700);
              } else {
                ShowMySnakbar(
                    title: 'خطا',
                    message: 'حدث خطا ما ',
                    backgroundColor: Colors.red.shade700);
              }
            },
            child: const Text('ارسال'),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}

class UploadImageWidget extends StatelessWidget {
  final VoidCallback onTap;
  final bool isUploaded;
  final File? image;

  const UploadImageWidget({
    Key? key,
    required this.onTap,
    required this.isUploaded,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: isUploaded
          ? DottedBorder(
              dashPattern: const [5, 5],
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              child: Container(
                height: 180,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  // border: Border.all(color: AppColors.kCTFFocusBorder),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'قم بتحميل صوره ',
                        style: GoogleFonts.notoKufiArabic(
                            textStyle:
                                const TextStyle(color: Color(0xFF3399CC))),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      const Icon(
                        Icons.image,
                        color: AppColors.mainColor,
                        size: 60,
                      ),
                    ],
                  ),
                ),
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                image!,
                fit: BoxFit.fill,
                height: 180,
                width: Get.width,
              ),
            ),
    );
  }
}

class UploadImagesWidget extends StatelessWidget {
  final VoidCallback onTap;
  final bool isUploaded;
  final List<XFile> image;

  const UploadImagesWidget({
    Key? key,
    required this.onTap,
    required this.isUploaded,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: isUploaded
          ? DottedBorder(
              dashPattern: const [5, 5],
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              child: Container(
                height: 180,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  // border: Border.all(color: AppColors.kCTFFocusBorder),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'قم بتحميل الصور',
                        style: GoogleFonts.notoKufiArabic(
                            textStyle:
                                const TextStyle(color: Color(0xFF3399CC))),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      const Icon(
                        Icons.image,
                        color: AppColors.mainColor,
                        size: 60,
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(
            child: SizedBox(
                height: 100,
                width: Get.width,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: image.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.file(
                        File(image[index].path),
                        fit: BoxFit.fill,
                        width: 100,
                        height: 100,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                )),
          ),
    );
  }
}