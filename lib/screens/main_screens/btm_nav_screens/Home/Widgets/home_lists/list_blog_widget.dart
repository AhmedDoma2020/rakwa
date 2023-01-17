import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_controllers/artical_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/model/artical_model.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/Home/Widgets/shimmer_card_home_loading.dart';
import 'package:rakwa/screens/one_artical_screen.dart';




class BlogWidget extends StatelessWidget {
  const BlogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return                             FutureBuilder<List<ArticalModel>>(
      future: ArticalApiController().getArticals(),
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const ShimmerCardHomeLoading();
        } else if (snapshot.hasData &&
            snapshot.data!.isNotEmpty) {
          return AnimationLimiter(
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) {
                return 16.ESH();
              },
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration
                    .staggeredList(
                  position: index,
                  duration:
                  const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                                () => OneArticalScreen(
                              articalModel:
                              snapshot.data![index],
                            ),
                          );
                        },
                        child: Center(
                          child: Container(
                            height: 360,
                            width: Get.width * 0.9,
                            decoration: BoxDecoration(
                              boxShadow:
                              AppBoxShadow.main,
                              borderRadius:
                              BorderRadius.circular(
                                  12),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [
                                Expanded(
                                    child: Stack(
                                      children: [
                                        snapshot.data![index]
                                            .featuredImage !=
                                            null
                                            ? ClipRRect(
                                          borderRadius: const BorderRadius
                                              .only(
                                              topLeft:
                                              Radius.circular(
                                                  12),
                                              topRight:
                                              Radius.circular(12)),
                                          child: Image
                                              .network(
                                            'https://www.rakwa.com/laravel_project/public${snapshot.data![index].featuredImage}',
                                            fit: BoxFit
                                                .cover,
                                            width: Get
                                                .width,
                                            height: double
                                                .infinity,
                                          ),
                                        )
                                        // : Image.network(
                                        //     'https://rakwa.com/theme_assets/frontend_assets/lduruo10_dh_frontend_city_path/placeholder/',
                                        //     fit: BoxFit.fill,
                                        //     width: Get.width,
                                        //   ),
                                            : ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(
                                              12),
                                          child: Image
                                              .asset(
                                            'images/logo.png',
                                            fit: BoxFit
                                                .cover,
                                            width: Get
                                                .width,
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding:
                                  const EdgeInsets
                                      .symmetric(
                                      horizontal:
                                      12),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Container(
                                        width: 200,
                                        child: Text(
                                          snapshot
                                              .data![
                                          index]
                                              .title ??
                                              '',
                                          overflow:
                                          TextOverflow
                                              .ellipsis,
                                          style: GoogleFonts
                                              .notoKufiArabic(
                                              textStyle:
                                              const TextStyle(
                                                fontSize:
                                                14,
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                              )),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  ),
                                )
                              ],
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
    );
  }
}
