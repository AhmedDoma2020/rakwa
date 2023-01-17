import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakwa/api/api_controllers/classified_api_controller.dart';
import 'package:rakwa/api/api_controllers/save_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/model/classified_by_id_model.dart';
import 'package:rakwa/screens/details_screen/details_classified_screen.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/widget/ads_widget.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/home_widget.dart';

class MyClassifiedScreen extends StatefulWidget {
  const MyClassifiedScreen({super.key});

  @override
  State<MyClassifiedScreen> createState() => _MyClassifiedScreenState();
}

class _MyClassifiedScreenState extends State<MyClassifiedScreen> with Helpers {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarDefault(title: "اعلاناتي"),
      body: FutureBuilder<List<ClassifiedByIdModel>>(
        future: ClassifiedApiController().getClassifiedById(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 12,
                );
              },
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return HomeWidget(
                    onTap: () {
                      print(snapshot.data![index].id);
                      Get.to(() => DetailsClassifiedScreen(
                          id: snapshot.data![index].id!));
                    },
                    saveOnPressed: () =>
                        saveItem(id: snapshot.data![index].id.toString()),
                    discount: '25',
                    image: snapshot.data![index].itemImage,
                    itemType: snapshot.data![index].itemCategoriesString ?? '',
                    location: snapshot.data![index].itemAddress ?? '',
                    title: snapshot.data![index].itemTitle ?? '',
                    rate: '100');
              },
            );
          } else {
            return const Center(
              child: Text('لا يوجد اعلانات'),
            );
          }
        },
      ),
    );
  }

  Future<void> saveItem({required String id}) async {
    bool status = await SaveApiController().saveClassified(classifiedId: id);
    if (status) {
      ShowMySnakbar(
          title: 'تم العملية بنجاح',
          message: 'تم حفظ العنصر بنجاح',
          backgroundColor: Colors.green.shade700);
    } else {
      ShowMySnakbar(
          title: 'خطأ',
          message: 'حدث خطأ ما',
          backgroundColor: Colors.red.shade700);
    }
  }
}