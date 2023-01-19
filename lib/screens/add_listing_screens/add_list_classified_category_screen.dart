import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/api/api_controllers/list_api_controller.dart';
import 'package:rakwa/controller/custom_field_getx_controller.dart';
import 'package:rakwa/model/all_categories_model.dart';
import 'package:rakwa/model/create_item_model.dart';
import 'package:rakwa/screens/add_listing_screens/Controllers/add_work_controller.dart';
import 'package:rakwa/screens/add_listing_screens/add_list-classified_subcategory_screen.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_category_screen.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_subcategory_screen.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_title_screen.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';

import '../../app_colors/app_colors.dart';
import '../../controller/list_controller.dart';
import '../../widget/next_step_button.dart';
import '../../widget/steps_widget.dart';

class AddListClassifiedCategoryScreen extends StatefulWidget {
  const AddListClassifiedCategoryScreen({super.key});

  @override
  State<AddListClassifiedCategoryScreen> createState() => _AddListClassifiedCategoryScreenState();
}

class _AddListClassifiedCategoryScreenState extends State<AddListClassifiedCategoryScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<AddWorkOrAdsController>();
    Get.delete<GetCustomFieldController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AddWorkOrAdsController addWordController =
    Get.put(AddWorkOrAdsController(isList: false));
    return Scaffold(
      appBar: AppBars.appBarDefault(title: "إضافة اعلان"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Expanded(
              child: FutureBuilder<List<AllCategoriesModel>>(
                future: ListApiController().getClassifiedCategory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          AnimationLimiter(
                            child: GridView.builder(
                              padding: EdgeInsets.zero,

                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
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
                                          addWordController.setParentCategory(
                                            snapshot.data![index].id,
                                          );
                                          addWordController.setCategoriesIds(
                                              snapshot.data![index].id);
                                          Get.to(
                                                () => AddListClassifiedSubCategoryScreen(
                                              categoryId: addWordController
                                                  .parentCategory,
                                            ),
                                          );
                                          },
                                        borderRadius: BorderRadius.circular(8),
                                        child: GetBuilder<AddWorkOrAdsController>(
                                          id: 'update_Classified_categories_ids',
                                            builder: (_) {
                                          return Material(
                                            elevation: 1,
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 2,
                                                  color: _.selectedCategoriesIds
                                                      .contains(snapshot
                                                      .data![index]
                                                      .id)
                                                      ? AppColors.mainColor
                                                      : Colors.transparent,
                                                ),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  snapshot.data![index]
                                                              .categoryImage !=
                                                          null
                                                      ? Image.network(
                                                          'https://www.rakwa.com/laravel_project/public/storage/category/${snapshot.data![index].categoryImage}',
                                                          height: 50,
                                                          width: 50,
                                                        )
                                                      : SizedBox(),
                                                  Text(
                                                    snapshot.data![index]
                                                        .categoryName,
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts
                                                        .notoKufiArabic(
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: Text('لا توجد تصنيفات'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}