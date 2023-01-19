import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/Core/services/dialogs.dart';
import 'package:rakwa/api/api_controllers/messages_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/widget/TextFields/text_field_default.dart';
import 'package:rakwa/widget/TextFields/validator.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/main_elevated_button.dart';
import 'package:rakwa/widget/my_text_field.dart';

class CreateMessage extends StatefulWidget {
  final String itemId;

  CreateMessage({required this.itemId});

  @override
  State<CreateMessage> createState() => _CreateMessageState();
}

class _CreateMessageState extends State<CreateMessage> with Helpers {
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
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              TextFieldDefault(
                upperTitle: "عنوان الرسالة",
                hint: 'ادخل عنوان الرسالة',
                prefixIconSvg: "address2",
                // prefixIconData: Icons.email_outlined,
                controller: _titleController,
                keyboardType: TextInputType.name,
                validation: addressMessageValidator,
                onComplete: () {
                  node.nextFocus();
                },
              ),
              const SizedBox(height: 24),
              TextFieldDefault(
                upperTitle: "الرسالة",
                hint: 'ادخل رسالتك ...',
                // prefixIconData: Icons.email_outlined,
                controller: _messageController,
                keyboardType: TextInputType.name,
                validation: messageValidator,
                maxLines: 5,
                onComplete: () {
                  node.unfocus();
                },
              ),
              const SizedBox(height: 40),
              MainElevatedButton(
                height: 56,
                width: Get.width,
                borderRadius: 12,
                onPressed: () async {
                  node.unfocus();
                  if (globalKey.currentState!.validate()) {
                    globalKey.currentState!.save();
                    setLoading();
                    bool status = await MessagesApiCpntroller().createMessage(
                      itemId: widget.itemId,
                      message: _messageController.text,
                      subject: _titleController.text,
                    );
                    Get.back();
                    if (status) {
                      Get.back();
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
}
