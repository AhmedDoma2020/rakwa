import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/api/api_controllers/save_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/model/all_saved_items_model.dart';
import 'package:rakwa/model/paid_items_model.dart';
import 'package:rakwa/screens/details_screen/details_classified_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/widget/SimmerLoading/simmer_loading_list_home_widget.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:shimmer/shimmer.dart';
import '../../widget/home_widget.dart';
import '../details_screen/details_screen.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarDefault(title: "العناصر المحفوظة"),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: TabBar(
            labelStyle: GoogleFonts.notoKufiArabic(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            unselectedLabelStyle: GoogleFonts.notoKufiArabic(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.mainColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 2.h,
            tabs: const [
              Tab(
                text: "الاعمال المحفوظة",
              ),
              Tab(
                text: "الاعلانات المحفوظة",
              ),
            ],
          ),
          body: const Padding(
            padding: EdgeInsets.only(top: 16),
            child: TabBarView(
              children: [
                SavedWorksTap(),
                SavedAdsTap(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SavedAdsTap extends StatefulWidget {
  const SavedAdsTap({Key? key}) : super(key: key);

  @override
  State<SavedAdsTap> createState() => _SavedAdsTapState();
}

class _SavedAdsTapState extends State<SavedAdsTap> with Helpers {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SavedItems>>(
      future: SaveApiController().getSaveClassified(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SimmerLoadingListHomeWidget();
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return HomeWidget(
                  percentCardWidth: .9,
                  onTap: () {
                    Get.to(() => DetailsClassifiedScreen(
                          id: snapshot.data![index].id,
                        ));
                  },
                  doMargin: false,
                  saveOnPressed: () => unSaveClassified(
                      id: snapshot.data![index].id.toString()),
                  discount: '25',
                  saveIcon: const Icon(
                    Icons.bookmark_outlined,
                    color: AppColors.mainColor,
                  ),
                  image: snapshot.data![index].itemImage,
                  itemType: snapshot.data![index].stateId.toString(),
                  location: snapshot.data![index].cityId.toString(),
                  title: snapshot.data![index].itemTitle,
                  rate: snapshot.data![index].itemAverageRating);
            },
          );
        } else {
          return const Center(child: Text('لم تقم بحفظ اي اعلانات'));
        }
      },
    );
  }

  Future<void> unSaveItem({required String id}) async {
    bool status = await SaveApiController().unSaveItem(itemId: id);
    if (status) {
      ShowMySnakbar(
          title: 'تم العملية بنجاح',
          message: 'تم ازالة العنصر بنجاح',
          backgroundColor: Colors.green.shade700);
      setState(() {});
    } else {
      ShowMySnakbar(
          title: 'خطأ',
          message: 'حدث خطأ ما',
          backgroundColor: Colors.red.shade700);
    }
  }

  Future<void> unSaveClassified({required String id}) async {
    bool status = await SaveApiController().unSaveClassified(classifiedId: id);
    if (status) {
      ShowMySnakbar(
          title: 'تم العملية بنجاح',
          message: 'تم ازالة العنصر بنجاح',
          backgroundColor: Colors.green.shade700);
      setState(() {});
    } else {
      ShowMySnakbar(
          title: 'خطأ',
          message: 'حدث خطأ ما',
          backgroundColor: Colors.red.shade700);
    }
  }
}

class SavedWorksTap extends StatefulWidget {
  const SavedWorksTap({Key? key}) : super(key: key);

  @override
  State<SavedWorksTap> createState() => _SavedWorksTapState();
}

class _SavedWorksTapState extends State<SavedWorksTap> with Helpers {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SavedItems>>(
      future: SaveApiController().getSaveItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SimmerLoadingListHomeWidget();
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return HomeWidget(
                  percentCardWidth: .9,
                  onTap: () {
                    Get.to(
                      () => DetailsScreen(
                        id: snapshot.data![index].id,
                      ),
                    );
                  },
                  doMargin: false,
                  saveOnPressed: () =>
                      unSaveItem(id: snapshot.data![index].id.toString()),
                  discount: '25',
                  saveIcon: const Icon(
                    Icons.bookmark_outlined,
                    color: AppColors.mainColor,
                  ),
                  image: snapshot.data![index].itemImage,
                  itemType: snapshot.data![index].stateId.toString(),
                  location: snapshot.data![index].cityId.toString(),
                  title: snapshot.data![index].itemTitle,
                  rate: snapshot.data![index].itemAverageRating);
            },
          );
        } else {
          return const Center(child: Text('لم تقم بحفظ اي عناصر'));
        }
      },
    );
  }

  Future<void> unSaveItem({required String id}) async {
    bool status = await SaveApiController().unSaveItem(itemId: id);
    if (status) {
      ShowMySnakbar(
          title: 'تم العملية بنجاح',
          message: 'تم ازالة العنصر بنجاح',
          backgroundColor: Colors.green.shade700);
      setState(() {});
    } else {
      ShowMySnakbar(
          title: 'خطأ',
          message: 'حدث خطأ ما',
          backgroundColor: Colors.red.shade700);
    }
  }

  Future<void> unSaveClassified({required String id}) async {
    bool status = await SaveApiController().unSaveClassified(classifiedId: id);
    if (status) {
      ShowMySnakbar(
          title: 'تم العملية بنجاح',
          message: 'تم ازالة العنصر بنجاح',
          backgroundColor: Colors.green.shade700);
      setState(() {});
    } else {
      ShowMySnakbar(
          title: 'خطأ',
          message: 'حدث خطأ ما',
          backgroundColor: Colors.red.shade700);
    }
  }
}
