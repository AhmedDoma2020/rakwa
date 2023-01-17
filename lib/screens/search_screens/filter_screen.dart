import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/api/api_controllers/search_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/controller/list_controller.dart';
import 'package:rakwa/controller/search_controller.dart';
import 'package:rakwa/model/all_categories_model.dart';
import 'package:rakwa/model/city_model.dart';
import 'package:rakwa/screens/add_listing_screens/Widget/bottom_sheet_city.dart';
import 'package:rakwa/screens/add_listing_screens/Widget/bottom_sheet_state.dart';
import 'package:rakwa/screens/search_screens/Widgets/bottom_sheet_classification.dart';
import 'package:rakwa/widget/TextFields/text_field_default.dart';
import 'package:rakwa/widget/TextFields/validator.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/home_widget.dart';
import 'package:rakwa/widget/main_elevated_button.dart';
import 'package:rakwa/widget/my_text_field.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rakwa/model/paid_items_model.dart';

// typedef Filter = void Function(String cityId);

class FilterScreen extends StatefulWidget {
  void Function(String cityId) cityId;
  void Function(String stateId) stateId;
  void Function(String category) category;
  void Function(String classifiedCategory) classifiedCategory;
  final bool isItem;

  FilterScreen({
    super.key,
    required this.category,
    required this.cityId,
    required this.classifiedCategory,
    required this.stateId,
    required this.isItem,
  });

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int? stateID = 0;
  int? cityID = 0;
  int? categoryID = 0;
  int? categoryClssifeidID = 0;
  dynamic selectedCity;
  dynamic selectedState;
  dynamic selectedCategory;
  dynamic selectedClssifiedCategory;

  ListController _listController = Get.put(ListController());
  SearchController _controller = Get.put(SearchController());

  late TextEditingController _searchController;
  late TextEditingController _stateController;
  late TextEditingController _cityController;
  late TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _stateController = TextEditingController();
    _cityController = TextEditingController();
    _categoryController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBars.appBarDefault(title: "فلترة"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              const SizedBox(height: 16),
              GetBuilder<ListController>(
                builder: (controller) => GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      BottomSheetState(
                        state: _listController.states,
                        bottomSheetTitle: "الولايات",
                        stateSelectedId: stateID ?? 0,
                        onSelect: (state) {
                          setState(() {
                            selectedState = state;
                            _stateController.text = state.stateName;
                            stateID = state.id;
                            if (selectedCity != null) {
                              selectedCity = null;
                              cityID = null;
                            }
                          });

                          _listController.getCitys(id: stateID.toString());
                        },
                      ),
                    );
                  },
                  child: TextFieldDefault(
                    enable: false,
                    upperTitle: "الولاية",
                    hint: 'اختار ولاية',
                    prefixIconSvg: "state",
                    suffixIconData: Icons.arrow_drop_down_sharp,
                    controller: _stateController,
                    validation: locationValidator,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GetBuilder<ListController>(
                builder: (controller) => GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      BottomSheetCity(
                        cities: _listController.citys,
                        bottomSheetTitle: "المدن",
                        citySelectedId: stateID ?? 0,
                        onSelect: (city) {
                          setState(() {
                            selectedCity = city;
                            _cityController.text = city.cityName;
                            cityID = city.id;
                          });
                        },
                      ),
                    );
                  },
                  child: TextFieldDefault(
                    enable: false,
                    upperTitle: "المدينة",
                    hint: 'اختار المدينة',
                    prefixIconSvg: "city",
                    suffixIconData: Icons.arrow_drop_down_sharp,
                    controller: _cityController,
                    validation: locationValidator,
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Visibility(
                visible: widget.isItem,
                child: GetBuilder<SearchController>(
                  builder: (controller) => GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        BottomSheetClassification(
                          categories: _controller.category,
                          bottomSheetTitle: "التصنيفات",
                          categorySelectedId: categoryID ?? 0,
                          onSelect: (category) {
                            setState(() {
                              selectedCategory = category;
                              _categoryController.text = category.categoryName;
                              categoryID = category.id;
                            });
                          },
                        ),
                      );
                    },
                    child: TextFieldDefault(
                      enable: false,
                      upperTitle: "التصنيف",
                      hint: 'اختار التصنيف',
                      prefixIconSvg: "address2",
                      suffixIconData: Icons.arrow_drop_down_sharp,
                      controller: _categoryController,
                      validation: locationValidator,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 16),
              //   width: Get.width,
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(12),
              //       color: Colors.white,
              //       boxShadow: [
              //         BoxShadow(
              //             offset: const Offset(0, 0),
              //             color: AppColors.labelColor.withOpacity(0.2),
              //             spreadRadius: 2,
              //             blurRadius: 5),
              //       ]),
              //   child: GetBuilder<SearchController>(
              //     builder: (controller) {
              //       return DropdownButton(
              //         underline: const Divider(
              //           thickness: 0,
              //         ),
              //         isExpanded: true,
              //         hint: const Text('اختار تصنيف'),
              //         onChanged: (value) {
              //           value as AllCategoriesModel;
              //           setState(() {
              //             selectedCategory = value;
              //             categoryID = value.id;
              //           });
              //         },
              //         value: selectedCategory,
              //         items: _controller.category
              //             .map((e) => DropdownMenuItem(
              //                 value: e, child: Text(e.categoryName)))
              //             .toList(),
              //       );
              //     },
              //   ),
              // ),
              // const SizedBox(
              //   height: 12,
              // ),
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 16),
              //   width: Get.width,
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(12),
              //       color: Colors.white,
              //       boxShadow: [
              //         BoxShadow(
              //             offset: const Offset(0, 0),
              //             color: AppColors.labelColor.withOpacity(0.2),
              //             spreadRadius: 2,
              //             blurRadius: 5),
              //       ]),
              //   child: GetBuilder<SearchController>(
              //     builder: (controller) {
              //       return DropdownButton(
              //         underline: const Divider(
              //           thickness: 0,
              //         ),
              //         isExpanded: true,
              //         hint: const Text('اختار تصنيف'),
              //         onChanged: (value) {
              //           value as AllCategoriesModel;
              //           setState(() {
              //             selectedClssifiedCategory = value;
              //             categoryClssifeidID = value.id;
              //           });
              //         },
              //         value: selectedClssifiedCategory,
              //         items: _controller.clssifiedCategory
              //             .map((e) => DropdownMenuItem(
              //                 value: e, child: Text(e.categoryName)))
              //             .toList(),
              //       );
              //     },
              //   ),
              // ),
              const Spacer(),
              MainElevatedButton(
                height: 60,
                width: Get.width * .9,
                borderRadius: 12,
                onPressed: () {
                  widget.stateId(stateID==0||stateID==null?"": stateID.toString());
                  widget.cityId(cityID==0||cityID==null?"":cityID.toString());
                  widget.category(categoryID==0||categoryID==null?"":categoryID.toString());
                  widget.classifiedCategory(categoryClssifeidID==0||categoryClssifeidID==null?"":categoryClssifeidID.toString());
                  Get.back();
                },
                child: Text(
                  'فلترة',
                  style: GoogleFonts.notoKufiArabic(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ));
  }
}
