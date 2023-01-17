import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/api/api_controllers/classified_api_controller.dart';
import 'package:rakwa/api/api_controllers/item_api_controller.dart';
import 'package:rakwa/api/api_controllers/search_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/model/paid_items_model.dart';
import 'package:rakwa/model/search_model.dart';
import 'package:rakwa/screens/details_screen/details_screen.dart';
import 'package:rakwa/screens/search_screens/filter_screen.dart';
import 'package:rakwa/widget/TextFields/text_field_default.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/home_widget.dart';
import 'package:rakwa/widget/my_text_field.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends StatefulWidget {
  final String? searchNumber;
  final bool isItem;

  SearchScreen({this.searchNumber, required this.isItem});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String cityId = '';
  String stateId = '';
  String category = '';
  String classifiedcategories = '';
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    print('========================================${widget.searchNumber}');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  final _form2Key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarDefault(title: "البحث"),
      body: Column(
        children: [
          searchAndFilterWidget(_form2Key),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<PaidItemsModel>>(
              future: widget.searchNumber == null
                  ? SearchApiController().search(
                      isItem: widget.isItem,
                      searchQuery: _searchController.text,
                      stateId: stateId,
                      category: category,
                      cityId: cityId,
                      classifiedcategories: classifiedcategories)
                  : widget.isItem
                      ?
                      //  SearchApiController().search(
                      //     searchQuery: _searchController.text,
                      //     stateId: stateId,
                      //     category: widget.searchNumber.toString(),
                      //     cityId: cityId,
                      //     classifiedcategories: '')
                      ItemApiController().searchItem(
                          cityId: cityId,
                          stateId: stateId,
                          category: widget.searchNumber.toString(),
                          classifiedcategories: classifiedcategories)
                      :
                      //  SearchApiController().search(
                      //     searchQuery: _searchController.text,
                      //     stateId: stateId,
                      //     category: '',
                      //     cityId: cityId,
                      //     classifiedcategories: widget.searchNumber.toString()),

                      ClassifiedApiController().searchClassified(
                          cityId: cityId,
                          stateId: stateId,
                          category: category,
                          classifiedcategories: widget.searchNumber.toString(),
                        ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer.fromColors(
                      baseColor: Colors.grey.shade100,
                      highlightColor: Colors.grey.shade300,
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        height: 236,
                        width: Get.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                      ));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return AnimationLimiter(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: HomeWidget(
                                  percentCardWidth: .9,
                                  onTap: () {
                                    Get.to(() => DetailsScreen(
                                        id: snapshot.data![index].id));
                                  },
                                  discount: '25',
                                  image: snapshot.data![index].itemImage,
                                  itemType: snapshot
                                      .data![index].itemCategoriesString,
                                  location: snapshot.data![index].city != null
                                      ? snapshot.data![index].city!.cityName
                                      : '',
                                  title: snapshot.data![index].itemTitle,
                                  rate:
                                      snapshot.data![index].itemAverageRating),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('لا توجد اي عناصر '),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding searchAndFilterWidget( GlobalKey<FormState> globalKey) {
    var node = FocusScope.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.kCTFEnableBorder),
          color: Colors.white,
        ),
        height: 60,
        child: Row(
          children: [
            Expanded(
              child: TextFieldDefault(
                autofocus: true,
                hint: 'ابحث عن...',
                enableBorder: Colors.transparent,
                controller: _searchController,
                prefixIconData: Icons.search,
                onChanged: (p0) {
                  setState(() {});
                },
                onComplete: () {
                  node.unfocus();
                },
              ),
            ),
            IconButton(
              color: Colors.white,
              onPressed: () {
                node.unfocus();
                Get.to(() => FilterScreen(
                      isItem: widget.isItem,
                      category: (newCategory) {
                        category = newCategory;
                        setState(() {});
                      },
                      cityId: (newCityId) {
                        cityId = newCityId;
                        print(cityId);
                        setState(() {});
                      },
                      classifiedCategory: (newClassifiedCategory) {
                        classifiedcategories = newClassifiedCategory;
                        setState(() {});
                      },
                      stateId: (newStateId) {
                        stateId = newStateId;
                        print(stateId);
                        print('=====================================');
                        setState(() {});
                      },
                    ));
              },
              icon: const Icon(
                Icons.filter_list_sharp,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
