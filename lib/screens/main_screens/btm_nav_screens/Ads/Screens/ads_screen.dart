import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_controllers/classified_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/screens/details_screen/details_classified_screen.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Ads/Widgets/all_ads_categories_widget.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Ads/Widgets/shimmer_loading_slider_home_widget.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Ads/Widgets/slider_card_ads.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Ads/Widgets/slider_nearest_ads_widget.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Ads/Widgets/slider_new_ads_wisget.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Ads/Widgets/slider_popular_ads_widget.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Home/Widgets/search_widget.dart';
import 'package:rakwa/screens/search_screens/search_screen.dart';
import 'package:rakwa/screens/view_all_classified_screens/view_all_classified_categories_screen.dart';
import 'package:rakwa/screens/view_all_classified_screens/view_all_classified_subcategories_screen.dart';
import 'package:rakwa/screens/view_all_classified_screens/view_all_latest_classified_screen.dart';
import 'package:rakwa/screens/view_all_classified_screens/view_all_paid_classified_screen.dart';
import 'package:rakwa/screens/view_all_classified_screens/view_all_popular_classified_screen.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/screens/view_all_classified_screens/view_all_nearest_classified_screen.dart';
import 'package:rakwa/widget/TitleWidgets/title_and_see_all_widget.dart';
import 'package:rakwa/widget/category_widget.dart';
import 'package:rakwa/widget/my_drawer.dart';
import 'package:rakwa/widget/my_text_field.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../api/api_controllers/home_api_controller.dart';
import '../../../../../api/api_controllers/save_api_controller.dart';
import '../../../../../model/all_categories_model.dart';
import '../../../../../model/classified_by_id_model.dart';
import '../../../../../model/paid_items_model.dart';
import '../../../../../widget/ads_widget.dart';
import '../../../../../widget/home_widget.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationLimiter(
        child: ListView(
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              30.ESH(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SearchWidget(isItem: false),
              ),
              24.ESH(),
              TitleAndSeeAllWidget(
                title: "التصنيفات",
                onSeeAllTap: () {
                  Get.to(() => const ViewAllClassififedCategoriesScreen());
                },
              ),
              const AllAdsCategoriesWidget(),
              24.ESH(),
              TitleAndSeeAllWidget(
                title: "الاقرب اليك",
                onSeeAllTap: () {
                  Get.to(() => const ViewAllNearestClassifiedScreen());
                },
              ),
              12.ESH(),
              const SliderNearestAdsWidget(),
              24.ESH(),
              TitleAndSeeAllWidget(
                title: "الأشهر",
                onSeeAllTap: () {
                  Get.to(() => const ViewAllPopularClassifiedScreen());
                },
              ),
              12.ESH(),
              const SliderPopularAdsWidget(),
              24.ESH(),
              TitleAndSeeAllWidget(
                title: "الأحدث",
                onSeeAllTap: () {
                  Get.to(() => const ViewAllLatestClassifiedScreen());
                },
              ),
              12.ESH(),
              const SliderNewAdsWidget(),
            ],
          ),
        ),
      ),
    );
  }
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

//TODO: MyAds Screen
