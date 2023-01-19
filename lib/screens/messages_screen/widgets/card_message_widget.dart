import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/model/messages_model.dart';



class CardMessage extends StatelessWidget {
  final bool isMe;
  final Message message;

  const CardMessage({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: isMe ? Alignment.topRight : Alignment.topLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          constraints: BoxConstraints(
            maxWidth: Get.width * .6,
          ),
          decoration: BoxDecoration(
              gradient:isMe? AppColors.mainGradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                   Colors.grey.shade200,
                  Colors.grey.shade200,
                ],
              ),
            borderRadius: BorderRadius.only(
              bottomRight: const Radius.circular(12),
              bottomLeft: const Radius.circular(12),
              topRight: Radius.circular(isMe ? 0 : 12),
              topLeft: Radius.circular(isMe ? 12 : 0),
            ),
          ),
          child: Text(
            message.body,
            style: GoogleFonts.notoKufiArabic(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: isMe ? TextAlign.start : TextAlign.end,
          ),
        ),
      ),
    );
  }
}
