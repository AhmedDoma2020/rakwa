import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/api/api_controllers/artical_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/model/artical_model.dart';
import 'package:rakwa/screens/one_artical_screen.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:shimmer/shimmer.dart';

class ArticalScreen extends StatefulWidget {
  const ArticalScreen({super.key});

  @override
  State<ArticalScreen> createState() => _ArticalScreenState();
}

class _ArticalScreenState extends State<ArticalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarDefault(title: "المقالات", isBack: false),
      body: FutureBuilder<List<ArticalModel>>(
        future: ArticalApiController().getArticals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer.fromColors(
                baseColor: Colors.grey.shade100,
                highlightColor: Colors.grey.shade300,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 12,
                    );
                  },
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(left: 8),
                      height: 153,
                      width: Get.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                    );
                  },
                ));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return AnimationLimiter(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 24,
                  );
                },
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                () => OneArticalScreen(
                                  articalModel: snapshot.data![index],
                                ),
                              );
                            },
                            child: Material(
                              elevation: .5,
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),

                              child: Container(
                                height: 140,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                      child: SizedBox(
                                        width: Get.width * 0.35,
                                        height: double.infinity,
                                        child: Image.network(
                                          width: Get.width * 0.35,
                                          height: double.infinity,
                                          'https://www.rakwa.com/laravel_project/public${snapshot.data![index].featuredImage}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 12,
                                          left: 8,
                                          top: 4,
                                          bottom: 4,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              // width: Get.width * 0.3,
                                              child: Text(
                                                snapshot.data![index].title!,
                                                maxLines: 3,
                                                style:
                                                    GoogleFonts.notoKufiArabic(
                                                  textStyle: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            Text(
                                              snapshot.data![index].summary !=
                                                      null
                                                  ? snapshot
                                                      .data![index].summary!
                                                  : '',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.notoKufiArabic(
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11,
                                                  color: AppColors
                                                      .describtionLabel,
                                                ),
                                              ),
                                            ),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const SizedBox(),
                                                Text(
                                                  snapshot
                                                      .data![index].publishedAt!
                                                      .toString(),
                                                  style: GoogleFonts.tajawal(
                                                    textStyle: const TextStyle(
                                                      fontWeight: FontWeight.normal,
                                                      color: AppColors
                                                          .describtionLabel,
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Text('لا توجد مقالات');
          }
        },
      ),
    );
  }
}
