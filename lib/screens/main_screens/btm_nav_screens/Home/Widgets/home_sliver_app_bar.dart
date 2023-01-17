
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Home/Widgets/search_widget.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Home/Widgets/top_home_screen_widget.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 260.h,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.transparent,
      // floating: true,
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: SizedBox(
          height: 260,
          width: Get.width,
          child: Stack(
            children: [
              TopHomeScreenWidget(),
              Positioned(
                bottom: 0,
                left: 16,
                right: 16,
                child: SearchWidget(
                  isItem: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
