import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_controllers/list_api_controller.dart';
import 'package:rakwa/controller/custom_field_getx_controller.dart';
import 'package:rakwa/model/all_categories_model.dart';
import 'package:rakwa/model/create_item_model.dart';
import 'package:rakwa/screens/add_listing_screens/Controllers/add_work_controller.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_subcategory_screen.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_title_screen.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:shimmer/shimmer.dart';

import '../../app_colors/app_colors.dart';
import '../../controller/list_controller.dart';
import '../../widget/next_step_button.dart';
import '../../widget/steps_widget.dart';

class AddListCategoryScreen extends StatefulWidget {
  const AddListCategoryScreen({super.key});

  @override
  State<AddListCategoryScreen> createState() => _AddListCategoryScreenState();
}

class _AddListCategoryScreenState extends State<AddListCategoryScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<AddWorkOrAdsController>();
    Get.delete<GetCustomFieldController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     Get.put(ListController());
    final AddWorkOrAdsController addWordController =
        Get.put(AddWorkOrAdsController(isList: true));
    // printDM("addWordController.selectedCategoryId is ${addWordController.selectedCategoryId}");
    return Scaffold(
      appBar: AppBars.appBarDefault(title: 'إضافة عمل'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: FutureBuilder<List<AllCategoriesModel>>(
                future: ListApiController().getCategory(),
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
                            crossAxisCount: 2,
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
                                            () => AddListSubCategoryScreen(
                                              categoryId: addWordController
                                                  .parentCategory,
                                            ),
                                          );
                                        },
                                        borderRadius: BorderRadius.circular(8),
                                        child: GetBuilder<AddWorkOrAdsController>(
                                          id: 'update_categories_ids',
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
                                                      textAlign:
                                                          TextAlign.center,
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
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          16.ESH(),
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
