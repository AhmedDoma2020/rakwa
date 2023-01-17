import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/screens/view_all_classified_screens/view_all_classified_subcategories_screen.dart';
import 'package:rakwa/screens/view_all_item_screens/view_all_subcategories_screen.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:shimmer/shimmer.dart';

import '../../api/api_controllers/home_api_controller.dart';
import '../../app_colors/app_colors.dart';
import '../../model/all_categories_model.dart';
import '../../widget/category_widget.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ViewAllCategoriesScreen extends StatefulWidget {
  const ViewAllCategoriesScreen({super.key});

  @override
  State<ViewAllCategoriesScreen> createState() =>
      _ViewAllCategoriesScreenState();
}

class _ViewAllCategoriesScreenState extends State<ViewAllCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBars.appBarDefault(title: 'التصنيفات'),
      body: Container(
               padding: const EdgeInsets.symmetric(horizontal: 16),

        child: FutureBuilder<List<AllCategoriesModel>>(
          future: HomeApiController().getCategory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Shimmer.fromColors(
                  baseColor: Colors.grey.shade100,
                  highlightColor: Colors.grey.shade300,
                  child: GridView.builder(
                    padding: EdgeInsets.zero,

                    itemCount: 18,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 12,
                      // mainAxisExtent: 60,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: AppColors.subTitleColor,
                            )),
                      );
                    },
                  ));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 16,),
                    AnimationLimiter(
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 12,
                          // mainAxisExtent: 60,
                        ),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            columnCount: snapshot.data!.length,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => ViewAllSubCategoriesScreen(
                                        id: snapshot.data![index].id,
                                        title: snapshot.data![index].categoryName,
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  child: Material(
                                    elevation: 1,
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,

                                        borderRadius: BorderRadius.circular(8),

                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          snapshot.data![index].categoryImage != null
                                              ? Image.network(
                                                  'https://www.rakwa.com/laravel_project/public/storage/category/${snapshot.data![index].categoryImage}',
                                                  height: 45,
                                                  width: 45,
                                                )
                                              : SizedBox(),
                                          Text(
                                            snapshot.data![index].categoryName,
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.notoKufiArabic(
                                                textStyle: const TextStyle(
                                                    fontWeight: FontWeight.w500)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16,),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('لا توجد اي تصنفيات '),
              );
            }
          },
        ),
      ),
    );
  }
}