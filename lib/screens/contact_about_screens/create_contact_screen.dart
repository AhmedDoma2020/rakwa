import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/api/api_controllers/contact_about_api_controller.dart';
import 'package:rakwa/api/api_controllers/messages_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/widget/TextFields/text_field_default.dart';
import 'package:rakwa/widget/TextFields/validator.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/main_elevated_button.dart';
import 'package:rakwa/widget/my_text_field.dart';

class CreateContactScreen extends StatefulWidget {
  const CreateContactScreen({super.key});

  @override
  State<CreateContactScreen> createState() => _CreateContactScreenState();
}

class _CreateContactScreenState extends State<CreateContactScreen>
    with Helpers {
  late TextEditingController _titleController;
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBars.appBarDefault(title: "ارسال رسالة"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              TextFieldDefault(
                upperTitle: "عنوان الرسالة",
                hint: 'ادخل عنوان الرسالة',
                prefixIconSvg: "address2",
                // prefixIconData: Icons.email_outlined,
                controller: _titleController,
                keyboardType: TextInputType.emailAddress,
                validation: addressMessageValidator,
                onComplete: () {
                  node.nextFocus();
                },
              ),
           const SizedBox(height: 16),
              TextFieldDefault(
                upperTitle: "الرسالة",
                hint: 'ادخل الرسالة',
                // prefixIconData: Icons.email_outlined,
                controller: _messageController,
                keyboardType: TextInputType.emailAddress,
                maxLines: 5,
                onComplete: () {
                  node.nextFocus();
                },
              ),
              const SizedBox(height: 16),
              const Spacer(),
              MainElevatedButton(
                height: 56,
                width: Get.width,
                borderRadius: 12,
                onPressed: () async {
                  if (globalKey.currentState!.validate()) {
                    globalKey.currentState!.save();
                    bool status = await ContactAboutApiController().createContact(
                        subject: _titleController.text,
                        message: _messageController.text);
                    if (status) {
                      ShowMySnakbar(
                          title: 'تمت العملية بنجاح',
                          message: 'تم ارسال رسالتك بنجاح',
                          backgroundColor: Colors.green.shade700);
                    } else {
                      ShowMySnakbar(
                          title: 'خطأ',
                          message: 'حدث خطأ ما',
                          backgroundColor: Colors.red.shade700);
                    }
                  }
                },
                child: Text(
                  'ارسال',
                  style: GoogleFonts.notoKufiArabic(
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool checkData() {
    if (_titleController.text.isNotEmpty &&
        _messageController.text.isNotEmpty) {
      return true;
    }
    ShowMySnakbar(
        title: 'حقل العنوان مطلوب',
        message: 'قم باضافة حقل العنوان',
        backgroundColor: Colors.red.shade700);
    return false;
  }
}
