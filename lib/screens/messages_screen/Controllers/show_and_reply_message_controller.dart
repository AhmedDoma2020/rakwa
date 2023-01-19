import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakwa/Core/services/dialogs.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_controllers/messages_api_controller.dart';
import 'package:rakwa/model/messages_model.dart';
import 'package:rakwa/screens/messages_screen/Controllers/get_all_message_controller.dart';

class ShowAndReplyMessageController extends GetxController {
  final String messageId;

  ShowAndReplyMessageController({required this.messageId});
  /// Show Message Data
  List<Message> messages=[];
  bool loadingShowMessage = false;

  Future<void> showMessage() async{
    printDM("enter her 1");
    loadingShowMessage = true;
    update(["update_show_message"]);
    BaseMessageModel? baseMessageModel =  await MessagesApiCpntroller().getMessages(id: messageId);
    if(baseMessageModel!=null){
      messages = List.from(baseMessageModel.message.reversed);
    }
    loadingShowMessage = false;
    update(["update_show_message"]);
  }
  /// Reply Message date
     GetAllMessageController getAllMessageController = Get.find();
  late TextEditingController messageController;
  bool loadingButton = false;

  Future<void> replyMessage() async {
    if (messageController.text.isNotEmpty) {
      loadingButton = true;
      update(["updateLoadingButton"]);
      bool status = await MessagesApiCpntroller().replyMessages(
        messageId: messageId,
        message: messageController.text,
      );
      loadingButton = false;
      if (status) {
        messageController.clear();
        showMessage();
        getAllMessageController.getAllMessage();
      }
      update(["updateLoadingButton"]);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    showMessage();
    messageController = TextEditingController();
    super.onInit();
  }
}
