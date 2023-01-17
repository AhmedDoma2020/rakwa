import 'package:flutter/material.dart';
import 'package:rakwa/api/api_controllers/messages_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/model/messages_model.dart';

class ShowMessagesScreen extends StatefulWidget {
  final String id;
  ShowMessagesScreen({required this.id});
  @override
  State<ShowMessagesScreen> createState() => _ShowMessagesScreenState();
}

class _ShowMessagesScreenState extends State<ShowMessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<MessagesModel?>(
        future: MessagesApiCpntroller().getMessages(id: widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ),
            );
          } else if (snapshot.hasData) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Subject : ${snapshot.data!.data!.subject!}'),
                Text('Message : ${snapshot.data!.message!.body!}'),
              ],
            ));
          } else {
            return const Center(child: Text('لا توجد رسائل'));
          }
        },
      ),
    );
  }
}
