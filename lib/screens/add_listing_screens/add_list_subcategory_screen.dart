import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/controller/list_controller.dart';
import 'package:rakwa/screens/add_listing_screens/Controllers/add_work_controller.dart';
import 'package:rakwa/screens/add_listing_screens/add_custom_field_screen.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_images_screen.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';

import '../../api/api_controllers/list_api_controller.dart';
import '../../app_colors/app_colors.dart';
import '../../model/all_categories_model.dart';
import '../../model/create_item_model.dart';
import '../../widget/next_step_button.dart';
import '../../widget/steps_widget.dart';
import 'add_list_title_screen.dart';

class AddListSubCategoryScreen extends StatefulWidget {
  final int categoryId;

  const AddListSubCategoryScreen({
    super.key,
    required this.categoryId,
  });

  @override
  State<AddListSubCategoryScreen> createState() =>
      _AddListSubCategoryScreenState();
}

class _AddListSubCategoryScreenState extends State<AddListSubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    AddWorkOrAdsController addWordController = Get.find();
    return Scaffold(
      appBar: AppBars.appBarDefault(title: 'إضافة عمل'),
      floatingActionButton: FloatingActionButtonNext(
        onTap: () {
          addWordController.navigationAfterSelectSubCategories();
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          24.ESH(),
          StepsWidget(selectedStep: 0),
          32.ESH(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FutureBuilder<List<AllCategoriesModel>>(
                future:
                    ListApiController().getSubCategory(id: widget.categoryId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return AnimationLimiter(
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 18,
                          mainAxisSpacing: 24,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            columnCount: snapshot.data!.length,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: InkWell(
                                  onTap: () {
                                    addWordController.setCategoriesIds(
                                        snapshot.data![index].id);
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  child: GetBuilder<AddWorkOrAdsController>(
                                    id: 'update_categories_ids',
                                      builder: (_) {
                                    return Material(
                                      elevation: 1,
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: _.selectedCategoriesIds
                                                    .contains(snapshot
                                                        .data![index].id)
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
                                              snapshot
                                                  .data![index].categoryName,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.notoKufiArabic(
                                                textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
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
                    );
                  } else {
                    Future.delayed(
                      const Duration(milliseconds: 1),
                      () {
                        addWordController.navigationAfterSelectSubCategories();
                      },
                    );
                    return const Center(
                      child: Text('لا توجد تصنيفات'),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

// CreateItemModel getCreateItemModel({required List<String>? subCategory}) {
//   CreateItemModel createItemModel = CreateItemModel();
//   createItemModel.itemType = '1';
//   createItemModel.itemFeatured = '0';
//   createItemModel.itemPostalCode = '34515';
//   createItemModel.itemHourShowHours = '1';
//
//   createItemModel.category.add(widget.categoryId.toString());
//   if (subCategory != null) {
//     createItemModel.category.addAll(subCategory);
//   }
//   return createItemModel;
// }
}

class FloatingActionButtonNext extends StatelessWidget {
  final VoidCallback onTap;

  const FloatingActionButtonNext({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(777),
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.mainColor,
              AppColors.mainColor.withOpacity(.5),
            ],
          ),
        ),
        child: Center(
          child: Text(
            'التالي',
            textAlign: TextAlign.center,
            style: GoogleFonts.notoKufiArabic(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
