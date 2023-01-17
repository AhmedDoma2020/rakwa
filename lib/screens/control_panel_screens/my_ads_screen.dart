// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../api/api_controllers/classified_api_controller.dart';
// import '../../app_colors/app_colors.dart';
// import '../../model/classified_by_id_model.dart';
// import '../../widget/ads_widget.dart';

// class MyAdsScreen extends StatefulWidget {
//   const MyAdsScreen({super.key});

//   @override
//   State<MyAdsScreen> createState() => _MyAdsScreenState();
// }

// class _MyAdsScreenState extends State<MyAdsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black),
//         title: Text(
//           'اعلاناتي',
//           style: GoogleFonts.notoKufiArabic(
//               textStyle: const TextStyle(
//             color: Colors.black,
//           )),
//         ),
//       ),
//       body: FutureBuilder<List<ClassifiedByIdModel>>(
//         future: ClassifiedApiController().getClassifiedById(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(
//                 color: AppColors.mainColor,
//               ),
//             );
//           } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 return AdsWidget(
//                     image: snapshot.data![index].itemImage ?? '',
//                     subTitle: snapshot.data![index].itemCategoriesString,
//                     title: snapshot.data![index].itemTitle);
//               },
//             );
//           } else {
//             return const Center(
//               child: Text('لا يوجد اعلانات'),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
