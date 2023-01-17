import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/model/details_model.dart';
import 'package:rakwa/screens/details_screen/gallery_screen/gallery_screen.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/widget/photo_view.dart';
import 'package:rakwa/widget/rate_stars_widget.dart';

class TopDetailsScreenWidget extends StatelessWidget with Helpers {
  final AsyncSnapshot<DetailsModel?> snapshot;

  TopDetailsScreenWidget({required this.snapshot, Key? key}) : super(key: key);
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 254,
      width: Get.width,
      child: Stack(
        children: [
          snapshot.data!.item!.galleries != null &&
                  snapshot.data!.item!.galleries!.isNotEmpty
              ? CarouselSlider(
                  carouselController: buttonCarouselController,
                  options: CarouselOptions(
                    height: double.infinity,
                    autoPlay: true,
                    viewportFraction: .96,
                    reverse: false,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.4,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: snapshot.data!.item!.galleries!.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          width: double.infinity,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              children: [
                                Image.network(
                                  'https://www.rakwa.com/laravel_project/public/storage/item/gallery/${i.itemImageGalleryName}',
                                  fit: BoxFit.cover,
                                  width: Get.width,
                                  height: double.infinity,
                                ),
                                Positioned.fill(
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                            Colors.white,
                                            Colors.black26,
                                            Colors.black,
                                          ])),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                )
              : Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => PhotoViewWidget(
                            imageProvider: NetworkImage(
                                'https://www.rakwa.com/laravel_project/public/storage/item/gallery/${snapshot.data!.item!.itemImage}'),
                          ),
                        );
                      },
                      child: Image.network(
                        'https://www.rakwa.com/laravel_project/public/storage/item/${snapshot.data!.item!.itemImage}',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.5,
                        child: Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Colors.white,
                                Colors.black26,
                                Colors.black,
                              ])),
                        ),
                      ),
                    ),
                  ],
                ),
          Positioned(
              left: 5,
              bottom: 10,
              child: snapshot.data!.item!.galleries != null &&
                      snapshot.data!.item!.galleries!.isNotEmpty
                  ? TextButton(
                      onPressed: () {
                        Get.to(() => GalleryScreen(
                            galleries: snapshot.data!.item!.galleries!));
                      },
                      // icon: Icon(
                      //   Icons.image,
                      //   size: 30,
                      //   color: Colors.grey.shade400,
                      // ),
                      child: Container(
                          height: 25,
                          width: 120,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color.fromARGB(255, 245, 65, 65),
                                    Color.fromARGB(255, 248, 169, 169)
                                  ]),

                              // color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            'مشاهدة جميع الصور',
                            style: GoogleFonts.notoKufiArabic(
                                textStyle: const TextStyle(
                                    fontSize: 10, color: Colors.white)),
                          ))),
                    )
                  : const SizedBox()),
          Positioned(
            right: 16,
            bottom: 19,
            child: RateStarsWidget(
                padding: true,
                rate: snapshot.data!.item!.itemAverageRating == null
                    ? null
                    : double.parse(
                        snapshot.data!.item!.itemAverageRating.toString())),
          ),
        ],
      ),
    );
  }
}