import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Ads/Widgets/list-popular_ads_widget.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Home/Widgets/card_add_work.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Home/Widgets/home_lists/list_blog_widget.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Home/Widgets/home_lists/list_nearest_items.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Home/Widgets/home_lists/list_popular_items.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Home/Widgets/home_lists/list_special_items.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Home/Widgets/home_lists/lsit_new_items.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Home/Widgets/home_sliver_app_bar.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Home/Widgets/slider_home_categories.dart';
import 'package:rakwa/screens/view_all_item_screens/view_all_latest_item_screen.dart';
import 'package:rakwa/screens/view_all_item_screens/view_all_nearest_item_screen.dart';
import 'package:rakwa/screens/view_all_item_screens/view_all_paid_item_screen.dart';
import 'package:rakwa/screens/view_all_item_screens/view_all_popular_item_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';
import 'package:rakwa/widget/TitleWidgets/title_and_see_all_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const HomeSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                AnimationLimiter(
                  child: Column(
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 500),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        24.ESH(),
                        // const CardAddWork(),
                        const CardAddWork(),
                        24.ESH(),
                        Column(
                          children: [
                            const SliderHomeCategories(),
                            24.ESH(),
                            TitleAndSeeAllWidget(
                              title: 'العناصر الاقرب اليك',
                              onSeeAllTap: () {
                                Get.to(() => const ViewAllNearestItemScreen());
                              },
                            ),
                            12.ESH(),
                            const NearestItems(),
                            24.ESH(),
                            TitleAndSeeAllWidget(
                              title: 'العناصر المميزة',
                              onSeeAllTap: () {
                                Get.to(() => const ViewAllPaidItemScreen());
                              },
                            ),
                            12.ESH(),
                            const SpecialItems(),
                            24.ESH(),
                            TitleAndSeeAllWidget(
                                title: 'الأشهر',
                                onSeeAllTap: () {
                                  Get.to(
                                      () => const ViewAllPopularItemScreen());
                                }),
                            12.ESH(),
                            const PopularItems(),
                            24.ESH(),
                            TitleAndSeeAllWidget(
                              title: 'الأحدث',
                              onSeeAllTap: () {
                                Get.to(() => const ViewAllLatestItemScreen());
                              },
                            ),
                            12.ESH(),
                            const NewItems(),
                            24.ESH(),
                            TitleAndSeeAllWidget(
                              title: 'الاعلانات',
                              onSeeAllTap: () {
                                Get.to(() => const ViewAllPaidItemScreen());
                              },
                            ),
                            12.ESH(),
                            const ListPopularAdsWidget(),
                            24.ESH(),
                            const TitleAndSeeAllWidget(
                              title: 'المقالات',
                              avalibleSeeAll: false,
                            ),
                            12.ESH(),
                            const BlogWidget(),
                            24.ESH(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
