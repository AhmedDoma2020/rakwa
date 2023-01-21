import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/screens/Auth/screens/reset_password_screen.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import '../../../api/api_controllers/auth_api_controller.dart';
import '../../../widget/main_elevated_button.dart';
import '../../../widget/text_field_code_widget.dart';

class CheckCodeScreen extends StatefulWidget {
  const CheckCodeScreen({super.key});

  @override
  State<CheckCodeScreen> createState() => _CheckCodeScreenState();
}

class _CheckCodeScreenState extends State<CheckCodeScreen> with Helpers {
  late FocusNode _firstfocusNode;
  late FocusNode _secfocusNode;
  late FocusNode _thirdfocusNode;
  late FocusNode _foruthfocusNode;
  late FocusNode _fithfocusNode;
  late FocusNode _sixthfocusNode;
  late TextEditingController _firstController;
  late TextEditingController _secController;
  late TextEditingController _thirdController;
  late TextEditingController _foruthController;
  late TextEditingController _fithController;
  late TextEditingController _sixthController;

  @override
  void initState() {
    super.initState();
    _firstfocusNode = FocusNode();
    _secfocusNode = FocusNode();
    _thirdfocusNode = FocusNode();
    _foruthfocusNode = FocusNode();
    _fithfocusNode = FocusNode();
    _sixthfocusNode = FocusNode();
    _firstController = TextEditingController();
    _secController = TextEditingController();
    _thirdController = TextEditingController();
    _foruthController = TextEditingController();
    _fithController = TextEditingController();
    _sixthController = TextEditingController();
  }

  @override
  void dispose() {
    _firstfocusNode.dispose();
    _secfocusNode.dispose();
    _thirdfocusNode.dispose();
    _foruthfocusNode.dispose();
    _fithfocusNode.dispose();
    _sixthfocusNode.dispose();
    _firstController.dispose();
    _secController.dispose();
    _thirdController.dispose();
    _foruthController.dispose();
    _fithController.dispose();
    _sixthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Spacer(),
            Image.asset('images/logo.jpg'),
            const SizedBox(
              height: 12,
            ),
            Text(
              'ادخل الرمز للتاكيد',
              style: GoogleFonts.notoKufiArabic(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFieldCodeWidget(
                    focusNode: _firstfocusNode,
                    textEditingController: _firstController,
                    onChanged: (p0) {
                      if (_firstController.text.isNotEmpty) {
                        _secfocusNode.requestFocus();
                      } else {}
                    },
                  ),
                  TextFieldCodeWidget(
                    focusNode: _secfocusNode,
                    textEditingController: _secController,
                    onChanged: (p0) {
                      if (_secController.text.isNotEmpty) {
                        _thirdfocusNode.requestFocus();
                      } else {
                        _firstfocusNode.requestFocus();
                      }
                    },
                  ),
                  TextFieldCodeWidget(
                    focusNode: _thirdfocusNode,
                    textEditingController: _thirdController,
                    onChanged: (p0) {
                      if (_thirdController.text.isNotEmpty) {
                        _foruthfocusNode.requestFocus();
                      } else {
                        _secfocusNode.requestFocus();
                      }
                    },
                  ),
                  TextFieldCodeWidget(
                    focusNode: _foruthfocusNode,
                    textEditingController: _foruthController,
                    onChanged: (p0) {
                      if (_foruthController.text.isNotEmpty) {
                        _fithfocusNode.requestFocus();
                      } else {
                        _thirdfocusNode.requestFocus();
                      }
                    },
                  ),
                  TextFieldCodeWidget(
                    focusNode: _fithfocusNode,
                    textEditingController: _fithController,
                    onChanged: (p0) {
                      if (_fithController.text.isNotEmpty) {
                        _sixthfocusNode.requestFocus();
                      } else {
                        _foruthfocusNode.requestFocus();
                      }
                    },
                  ),
                  TextFieldCodeWidget(
                    focusNode: _sixthfocusNode,
                    textEditingController: _sixthController,
                    onChanged: (p0) {
                      if (_sixthController.text.isNotEmpty) {
                      } else {
                        _fithfocusNode.requestFocus();
                      }
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            MainElevatedButton(
              height: 56,
              width: Get.width,
              borderRadius: 12,
              onPressed: checkCode,
              child: Text(
                'تاكيد',
                style: GoogleFonts.notoKufiArabic(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }

  Future<void> checkCode() async {
    String code =
        '${_firstController.text}'
        '${_secController.text}'
        '${_thirdController.text}'
        '${_foruthController.text}'
        '${_fithController.text}'
        '${_sixthController.text}'
    ;
    printDM("code is $code");
    bool status = await AuthApiController().checkCode(code: code);

    if (status) {
      ShowMySnakbar(
          title: 'تم العملية بنجاح',
          message: 'تم التاكد من هويتك',
          backgroundColor: Colors.green.shade400);
      Get.to(() => ResetPasswordScreen(
            code: code,
          ));
    } else {
      ShowMySnakbar(
          title: 'خطأ',
          message: 'الكود غير صحيح',
          backgroundColor: Colors.red.shade700);
    }
  }
}
