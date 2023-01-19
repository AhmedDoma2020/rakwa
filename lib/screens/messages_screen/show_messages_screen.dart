import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:rakwa/Core/services/dialogs.dart';
import 'package:rakwa/api/api_controllers/messages_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/model/messages_model.dart';
import 'package:rakwa/screens/messages_screen/Controllers/show_and_reply_message_controller.dart';
import 'package:rakwa/screens/messages_screen/widgets/card_message_widget.dart';
import 'package:rakwa/screens/messages_screen/widgets/field_add_message_widget.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';
import 'package:rakwa/widget/Loading/loading_dialog.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';

class ShowMessagesScreen extends StatefulWidget {
  final String messageId;
  final String subject;

  const ShowMessagesScreen(
      {super.key, required this.messageId, required this.subject});

  @override
  State<ShowMessagesScreen> createState() => _ShowMessagesScreenState();
}

class _ShowMessagesScreenState extends State<ShowMessagesScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<ShowAndReplyMessageController>();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Get.put(ShowAndReplyMessageController(messageId: widget.messageId));
    return Scaffold(
      appBar: AppBars.appBarDefault(title: widget.subject),
      body: Stack(
        children: <Widget>[
          GetBuilder<ShowAndReplyMessageController>(
            id: 'update_show_message',
            builder: (_) {
              return _.loadingShowMessage
                  ? const Loader()
                  : _.messages.isNotEmpty
                      ? ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 10, bottom: 82),
                          // physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => CardMessage(
                            isMe: _.messages[index].user.id.toString() ==
                                SharedPrefController().id,
                            message: _.messages[index],
                          ),
                          itemCount: _.messages.length,
                        )
                      : const Center(child: Text("لا يوجد رسائل"));
            },
          ),
          const FieldAddMessage(),
        ],
      ),
    );
  }
}
