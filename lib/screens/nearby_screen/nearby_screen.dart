import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/api/api_controllers/details_api_controller.dart';
import 'package:rakwa/model/nearby_model.dart';
import 'package:rakwa/screens/details_screen/details_screen.dart';
import 'package:rakwa/widget/home_widget.dart';
import 'package:shimmer/shimmer.dart';

class NearbyScreen extends StatefulWidget {
  final double lat;
  final double lng;
  NearbyScreen({required this.lat, required this.lng});

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'الاعمال القريبة منك',
          style: GoogleFonts.notoKufiArabic(
              textStyle: const TextStyle(
            color: Colors.black,
          )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
        child: FutureBuilder<List<NearbyModel>>(
          future: DetailsApiController().getNearbyItems(
            lat: widget.lat,
            lng: widget.lng
          ),
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
                        height: 236,
                        width: Get.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                      );
                    },
                  ));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.separated(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 12,
                  );
                },
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return HomeWidget(
                      onTap: () {
                        Get.to(
                            () => DetailsScreen(id: snapshot.data![index].id!));
                      },
                      doMargin: false,
                      discount: '25',
                      image: snapshot.data![index].itemImage,
                      itemType: snapshot.data![index].itemCategoriesString!,
                      location: snapshot.data![index].city!.cityName!,
                      title: snapshot.data![index].itemTitle!,
                      rate: snapshot.data![index].itemAverageRating);
                },
              );
            } else {
              return const Center(
                child: Text('لا توجد اي عناصر '),
              );
            }
          },
        ),
      ),
    );
  }
}
