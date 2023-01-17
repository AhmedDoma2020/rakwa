import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/More/Widgets/container_card_icon_title_arrow_widget.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/More/Widgets/custom_more_screen_divider.dart';
import 'package:rakwa/screens/view_all_classified_screens/view_all_classified_subcategories_screen.dart';
import 'package:rakwa/screens/view_all_classified_screens/widgets/card_all_categories_screen.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/category_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../api/api_controllers/home_api_controller.dart';
import '../../app_colors/app_colors.dart';
import '../../model/all_categories_model.dart';

class ViewAllClassififedCategoriesScreen extends StatefulWidget {
  const ViewAllClassififedCategoriesScreen({super.key});

  @override
  State<ViewAllClassififedCategoriesScreen> createState() =>
      _ViewAllClassififedCategoriesScreenState();
}

class _ViewAllClassififedCategoriesScreenState
    extends State<ViewAllClassififedCategoriesScreen> {
  List colors = const [
    Color.fromARGB(255, 224, 20, 81),
    Color.fromARGB(255, 45, 106, 228),
    Color.fromARGB(255, 159, 6, 254),
    Color.fromARGB(255, 219, 242, 12),
    Color.fromARGB(255, 224, 20, 81),
    Color.fromARGB(255, 45, 106, 228),
    Color.fromARGB(255, 159, 6, 254),
    Color.fromARGB(255, 219, 242, 12)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBars.appBarDefault(title: "التصنيفات"),
        body: FutureBuilder<List<AllCategoriesModel>>(
          future: HomeApiController().getAllClassifiedCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade100,
                highlightColor: Colors.grey.shade300,
                child: ContainerCardIconTitleArrowWidget(
                    widget: SizedBox(
                  height: Get.height * .9,
                  width: Get.width * .9,
                )),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ContainerCardIconTitleArrowWidget(
                widget: ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => CardAllCategoriesScreen(
                    title: snapshot.data![index].categoryName,
                    onTap: () {
                      Get.to(
                        () => ViewAllClassifiedSubCategoriesScreen(
                          id: snapshot.data![index].id,
                          categoryName: snapshot.data![index].categoryName,
                        ),
                      );
                    },
                    icon: snapshot.data![index].categoryImage!,
                  ),
                  separatorBuilder: (context, index) =>
                      const CustomMoreScreenDivider(),
                  itemCount: snapshot.data!.length,
                ),
              );
            } else {
              return const Center(
                child: Text('لا توجد اي تصنفيات '),
              );
            }
          },
        ));
  }
}