import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:rakwa/Core/services/dialogs.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_controllers/messages_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/screens/messages_screen/Controllers/show_and_reply_message_controller.dart';
import 'package:rakwa/widget/Loading/loading_dialog.dart';
import 'package:rakwa/widget/TextFields/text_field_default.dart';

class FieldAddMessage extends StatelessWidget {

  const FieldAddMessage({super.key});

  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);
    return Align(
      alignment: Alignment.bottomLeft,
      child: GetBuilder<ShowAndReplyMessageController>(
        id: 'updateLoadingButton',
        builder:(_) =>  Container(
          padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
          height: 80,
          width: double.infinity,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              _.loadingButton?const Loader() :
              IconButton(
                onPressed: () {
                  node.nextFocus();
                  _.replyMessage();
                },
                icon: const Directionality(
                  textDirection: TextDirection.ltr,
                  child: Icon(
                    Icons.send,
                    color: AppColors.mainColor,
                    size: 18,
                  ),
                ),
              ),
              Expanded(
                child: TextFieldDefault(
                  hint: 'اكتب رساله',
                  controller: _.messageController,
                  keyboardType: TextInputType.text,
                  onComplete: () async {
                    node.nextFocus();
                   _.replyMessage();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
