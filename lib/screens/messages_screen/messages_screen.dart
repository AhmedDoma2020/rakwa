import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakwa/api/api_controllers/messages_api_controller.dart';
import 'package:rakwa/model/all_messages_model.dart';
import 'package:rakwa/screens/messages_screen/show_messages_screen.dart';
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
    return Scaffold(
      appBar: AppBars.appBarDefault(title: "المسجات"),
      body: FutureBuilder<List<AllMessagesModel>>(
        future: MessagesApiCpntroller().getAllMessages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemCount: 9,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                    baseColor: Colors.grey.shade100,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      height: 80,
                      width: Get.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                    ));
              },
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Get.to(() => ShowMessagesScreen(
                        id: snapshot.data![index].id.toString()));
                  },
                  title: Text(snapshot.data![index].subject!),
                  subtitle: Text(snapshot.data![index].createdAt!),
                );
              },
            );
          } else {
            return const Center(child: Text('لا توجد رسائل'));
          }
        },
      ),
    );
  }
}