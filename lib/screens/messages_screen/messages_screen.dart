import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakwa/api/api_controllers/messages_api_controller.dart';
import 'package:rakwa/model/all_messages_model.dart';
import 'package:rakwa/screens/messages_screen/Controllers/get_all_message_controller.dart';
import 'package:rakwa/screens/messages_screen/widgets/card_all_message.dart';
import 'package:rakwa/screens/messages_screen/widgets/shimmer_all_message.dart';
import 'package:rakwa/widget/Loading/loading_dialog.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:shimmer/shimmer.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(GetAllMessageController());
    return Scaffold(
      appBar: AppBars.appBarDefault(title: "المسجات"),
      body: GetBuilder<GetAllMessageController>(
        id: 'updateAllMessage',
        builder: (_) {
          return _.loadingGetAllMessage
              ? const Loader()
              : _.allMessages.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (context, index) =>
                          const Divider(thickness: 1),
                      physics: const BouncingScrollPhysics(),
                      itemCount: _.allMessages.length,
                      itemBuilder: (context, index) {
                        return CardAllMessage(
                          allMessages: _.allMessages[index],
                        );
                      },
                    )
                  : const Center(
                      child: Text('لا توجد رسائل'),
                    );
        },
      ),
    );
  }
}
