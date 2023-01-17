import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/controller/list_controller.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_subcategory_screen.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';

import '../../api/api_controllers/list_api_controller.dart';
import '../../app_colors/app_colors.dart';
import '../../model/all_categories_model.dart';
import '../../model/create_item_model.dart';
import '../../widget/next_step_button.dart';
import '../../widget/steps_widget.dart';
import 'add_list_title_screen.dart';

class AddListClassifiedSubCategoryScreen extends StatefulWidget {
  final int id;

  const AddListClassifiedSubCategoryScreen({super.key, required this.id});

  @override
  State<AddListClassifiedSubCategoryScreen> createState() =>
      _AddListClassifiedSubCategoryScreenState();
}

class _AddListClassifiedSubCategoryScreenState
    extends State<AddListClassifiedSubCategoryScreen> {
  ListController _listController = Get.find();
  List<String>? selectedSubID = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarDefault(title: 'إضافة اعلان'),
      floatingActionButton: FloatingActionButtonNext(
        onTap: () {
          ///
          // Get.to(() => AddListTitleScreen(
          //     createItemModel: getCreateItemModel(subCategory: selectedSubID!),
          //     isList: false,
          //   ));
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          StepsWidget(selectedStep: 0),
          const SizedBox(
            height: 32,
          ),
          Expanded(
            child
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FutureBuilder<List<AllCategoriesModel>>(
                future:
                    ListApiController().getClassifiedSubCategory(id: widget.id),
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
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 18,
                                mainAxisSpacing: 24),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            columnCount: snapshot.data!.length,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: InkWell(
                                  onTap:  () {
                                    ///
                                    // _listController.changeSubCategory(index);
                                    // if (selectedSubID != null &&
                                    //     selectedSubID!.contains(
                                    //         snapshot.data![index].id.toString())) {
                                    //   selectedSubID!
                                    //       .remove(snapshot.data![index].id.toString());
                                    // } else {
                                    //   selectedSubID!
                                    //       .add(snapshot.data![index].id.toString());
                                    // }
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  child: GetBuilder<ListController>(
                                      builder: (controller) {
                                    return Material(
                                      elevation: 1,
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: selectedSubID != null &&
                                                    selectedSubID!.contains(
                                                        snapshot.data![index].id
                                                            .toString())
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
                        ///
                        // Get.off(() => AddListTitleScreen(
                        //       createItemModel:
                        //           getCreateItemModel(subCategory: null),
                        //       isList: false,
                        //     ));
                      },
                    );
                    return const Center(child: Text('لا توجد تصنيفات'));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  CreateItemModel getCreateItemModel({required List<int>? subCategory}) {
    CreateItemModel createItemModel = CreateItemModel();
    createItemModel.itemType = '1';
    createItemModel.itemFeatured = '0';
    createItemModel.itemPostalCode = '34515';
    createItemModel.itemHourShowHours = '1';
    createItemModel.category.add(widget.id);
    if (subCategory != null) {
      createItemModel.category.addAll(subCategory);
    }

    return createItemModel;
  }
}