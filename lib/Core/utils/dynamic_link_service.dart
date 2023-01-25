import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/screens/details_screen/details_screen.dart';
import 'package:rakwa/screens/messages_screen/messages_screen.dart';
import 'package:share_plus/share_plus.dart';

import 'package:flutter/material.dart';

//
// class FirebaseDynamicLinkService {
//   static Future<String> createDynamicLink(bool short, String id) async {
//     String _linkMessage;
//
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: 'https://rakwa.page.link',
//       link: Uri.parse('https://rakwa.page.link/Kz3a'),
//       androidParameters: AndroidParameters(
//         packageName: 'com.example.rakwa',
//         minimumVersion: 0,
//       ),
//       iosParameters: const IOSParameters(
//         bundleId: 'com.turkey.rakwa',
//         minimumVersion: '1',
//         appStoreId: '1660636889',
//       ),
//     );
//
//         Uri url;
//     if (short) {
//       final ShortDynamicLink shortLink =
//       await FirebaseDynamicLinks.instance.buildShortLink(parameters);
//       url = shortLink.shortUrl;
//     } else {
//       url = await FirebaseDynamicLinks.instance.buildLink(parameters);
//     }
//
//     Share.share(url.toString(), subject: 'eat');
//
//     _linkMessage = url.toString();
//     return _linkMessage;
//   }
//
//   static Future<void> initDynamicLink(BuildContext context) async {
//     FirebaseDynamicLinks.instance.getInitialLink().then((data) {
//       final Uri deepLink = data!.link;
//       printDM("deepLink.pathSegments is 1");
//       printDM("deepLink.pathSegments is ${deepLink.pathSegments}");
//       var isCategory = deepLink.pathSegments.contains('category');
//       if (isCategory) {
//         String? id = deepLink.queryParameters['id'];
//         print("ID :::: $id");
//         Get.to(() => DetailsScreen(
//               id: id!,
//             ));
//       }
//     });
//
//     final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
//
//     try {
//       final Uri deepLink = initialLink!.link;
//       var isCategory = deepLink.pathSegments.contains('category');
//       if (isCategory) {
//         // TODO :Modify Accordingly
//         String? id = deepLink.queryParameters['id'];
//         print("ID :::: $id");
//         Get.to(() => DetailsScreen(
//           id: id!,
//         ));
//         // TODO : Navigate to your pages accordingly here
//
//       }
//     } catch (e) {
//       print('No deepLink found');
//     }
//   }
// }

FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

class DynamicLink {
  Future<String> createDynamicLink(
      {
       required bool short,
        required   String id,
        required  String title,
        required  String description,
        required String image,
      }) async {
    printDM("image is $image");
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://rakwa.page.link',
      link: Uri.parse('https://rakwa.page.link/category?id=$id'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.rakwa',
        minimumVersion: 1,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.turkey.rakwa',
        minimumVersion: '1',
        appStoreId: '1660636889',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: title,
        description: description,
        imageUrl: Uri.parse(image),
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }
    Share.share(url.toString());
    String _dynamicLink = url.toString();
    return _dynamicLink;
  }

  Future<void> retrieveDynamicLink() async {
    try {
      Uri? deepLink;
      FirebaseDynamicLinks.instance.getInitialLink().then((data) {
        deepLink = data?.link;
        printDM("deepLink.pathSegments is ");
        if (deepLink != null) {
          printDM("deepLink.pathSegments is ${deepLink!.queryParameters}");
          String? id = deepLink!.queryParameters['id'] ?? "";
          if (id != "") {
            print("ID :::: $id");
            Get.to(
              () => DetailsScreen(
                id: id.toString(),
              ),
            );
          }
        }
      });
      dynamicLinks.onLink.listen((dynamicLinkData) async {
        final Uri deepLink = await dynamicLinkData.link;
        String id = deepLink.queryParameters['id'] ?? "";
        print(' id....................... $id');
        if (id != '' && id != null) {
          Get.to(() => DetailsScreen(
                id: id.toString(),
              ));
        }
      }).onError((error) {
        print('onLink error');
        print(error.message);
      });
    } catch (e) {
      print('onLink error');
      print(e.toString());
    }
  }
}

// https://rakwa.page.link?sd=description&si=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2F7%2F73%2FLion_waiting_in_Namibia.jpg&st=title&amv=1&apn=com.example.rakwa&ibi=com.turkey.rakwa&imv=1&isi=1660636889&link=https%3A%2F%2Frakwa.page.link%2Fcategory%3Fid%3D256
//https://rakwa.page.link/?isi=1660636889&ibi=com.turkey.rakwa&efr=0&imv=1&link=https%3A%2F%2Frakwa.page.link%2Fcategory%3Fid%3D256&si=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2F7%2F73%2FLion_waiting_in_Namibia.jpg&sd=description&amv=1&st=title&apn=com.example.rakwa
//https://rakwa.page.link?sd=description&si=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2F7%2F73%2FLion_waiting_in_Namibia.jpg&st=title&amv=1&apn=com.example.rakwa&ibi=com.turkey.rakwa&imv=1&isi=1660636889&link=https%3A%2F%2Frakwa.page.link%2Fcategory%3Fid%3D768
// https://rakwa.page.link/s4QR
//https://rakwa.page.link/WGAX
