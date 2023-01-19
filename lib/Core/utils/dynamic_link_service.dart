//
//
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:get/get.dart';
// import 'package:share_plus/share_plus.dart';
//
//
//
// class DynamicLink {
//
//   Future<void> retrieveDynamicLink() async {
//     try {
//       Uri? deepLink;
//       FirebaseDynamicLinks.instance.getInitialLink().then((data) {
//         deepLink = data?.link;
//         if (deepLink != null) {
//           String? id = deepLink!.queryParameters['id'];
//           print("ID :::: $id");
//           // appControler.setDlFlag(true);
//           /// Get.to(() => CreatorProfileView(id: id.toString()));
//         }
//       });
//
//       FirebaseDynamicLinks.instance.onLink(
//           onSuccess: (PendingDynamicLinkData? dynamicLink) async {
//             final Uri deepLink = dynamicLink!.link;
//             String? id = deepLink.queryParameters['id'];
//             print(' id....................... $id');
//             // Get.to(() => DLScreen('onResume__ prodcut'));
//
//             /// Get.to(() => CreatorProfileView(id: id.toString()));
//
//           });
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   Future<Uri> createDynamicLink(String id) async {
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: 'https://almobtaker.page.link',
//       link: Uri.parse('https://almobtaker.page.link/creators/?id=$id'),
//       androidParameters: AndroidParameters(
//         packageName: 'com.example.almobtaker',
//         minimumVersion: 1,
//       ),
//       // iosParameters: IosParameters(
//       //   bundleId: 'your_ios_bundle_identifier',
//       //   minimumVersion: '1',
//       //   appStoreId: 'your_app_store_id',
//       // ),
//       socialMetaTagParameters: SocialMetaTagParameters(
//           title: 'title',
//           description: "description",
//           imageUrl: Uri.parse(
//               'https://upload.wikimedia.org/wikipedia/commons/7/73/Lion_waiting_in_Namibia.jpg')),
//     );
//     var dynamicUrl = await parameters.buildUrl();
//     ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
//     Uri shortUrl = shortDynamicLink.shortUrl;
//     Share.share(shortUrl.toString(), subject: 'eat');
//     return dynamicUrl;
//   }
// }