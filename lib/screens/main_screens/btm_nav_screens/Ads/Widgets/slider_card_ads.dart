import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_controllers/classified_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/screens/details_screen/details_classified_screen.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Ads/Screens/ads_screen.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Ads/Widgets/slider_popular_ads_widget.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Home/Widgets/search_widget.dart';
import 'package:rakwa/screens/search_screens/search_screen.dart';
import 'package:rakwa/screens/view_all_classified_screens/view_all_classified_categories_screen.dart';
import 'package:rakwa/screens/view_all_classified_screens/view_all_classified_subcategories_screen.dart';
import 'package:rakwa/screens/view_all_classified_screens/view_all_latest_classified_screen.dart';
import 'package:rakwa/screens/view_all_classified_screens/view_all_paid_classified_screen.dart';
import 'package:rakwa/screens/view_all_classified_screens/view_all_popular_classified_screen.dart';
import 'package:rakwa/Core/utils/helpers.dart';
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



class SliderCardAds extends StatelessWidget  {
  final int length;
  final List<PaidItemsModel> ads;

  const SliderCardAds({
    Key? key,
    required this.length,
    required this.ads,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: length <= 8 ? length : 8,
      separatorBuilder: (context, index) => const SizedBox(
        width: 16,
      ),
      itemBuilder: (context, index) {
        return HomeWidget(
          onTap: () {
            Get.to(() => DetailsClassifiedScreen(id: ads[index].id));
          },
          saveOnPressed: () => saveItem(id: ads[index].id.toString()),
          discount: '25',
          image: ads[index].itemImage,
          itemType: ads[index].state?.stateName ?? '',
          location: ads[index].city?.cityName ?? '',
          title: ads[index].itemTitle,
          rate: '100',
        );
      },
    );
  }

}
