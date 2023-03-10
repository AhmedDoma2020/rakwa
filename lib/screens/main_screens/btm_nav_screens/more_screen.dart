import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/api/api_controllers/auth_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_category_screen.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_classified_category_screen.dart';
import 'package:rakwa/screens/contact_about_screens/about_screen.dart';
import 'package:rakwa/screens/contact_about_screens/contact_screen.dart';
import 'package:rakwa/screens/contact_about_screens/create_contact_screen.dart';
import 'package:rakwa/screens/contact_about_screens/privacy_policy_screen.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/More/Widgets/card_more_screen.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/More/Widgets/container_card_icon_title_arrow_widget.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/More/Widgets/custom_more_screen_divider.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/More/Widgets/user_info_widget.dart';
import 'package:rakwa/screens/main_screens/btm_nav_screens/control_panel_screen.dart';
import 'package:rakwa/screens/messages_screen/messages_screen.dart';
import 'package:rakwa/screens/my_items_classifieds_screens/my_classifieds_screen.dart';
import 'package:rakwa/screens/my_items_classifieds_screens/my_item_screen.dart';
import 'package:rakwa/screens/save_screen/save_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> with Helpers {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 40),
            const UserInfoWidget(),
            const SizedBox(height: 24),
            ContainerCardIconTitleArrowWidget(
              widget: Column(
                children: [
                  CardMoreScreen(
                    onTap: () {
                      Get.to(() => const ControlPanelScreen());
                    },
                    title: "??????????????",
                    icon: "MActivty",
                  ),
                  const CustomMoreScreenDivider(),
                  CardMoreScreen(
                    onTap: () {
                      Get.to(() => const SaveScreen());
                    },
                    title: "?????????????? ????????????????",
                    icon: "MSave",
                  ),
                  const CustomMoreScreenDivider(),
                  CardMoreScreen(
                    onTap: () {
                      Get.to(() => const MyItemScreen());
                    },
                    title: "??????????????",
                    icon: "MProjects",
                  ),
                  const CustomMoreScreenDivider(),
                  CardMoreScreen(
                    onTap: () {
                      Get.to(() => const MyClassifiedScreen());
                    },
                    title: "????????????????",
                    icon: "MAds",
                  ),
                  const CustomMoreScreenDivider(),
                  CardMoreScreen(
                    onTap: () {
                      Get.to(() => const MessagesScreen());
                    },
                    title: "??????????????",
                    icon: "message",
                  ),
                  const CustomMoreScreenDivider(),
                  CardMoreScreen(
                    onTap: () {
                      Get.to(() => const CreateContactScreen());
                    },
                    title: "?????????? ????????",
                    icon: "MContact",
                  ),
                  const CustomMoreScreenDivider(),
                  CardMoreScreen(
                    onTap: () async {
                      if (SharedPrefController().isLogined) {
                        bool status = await AuthApiController().logout();
                      } else {
                        Get.offAllNamed('/sign_in_screen');
                      }
                    },
                    title: SharedPrefController().isLogined
                        ? "?????????? ????????????"
                        : "?????????? ????????????",
                    icon: "MLogout",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            ContainerCardIconTitleArrowWidget(
              widget: Column(
                children: [
                  CardMoreScreen(
                    onTap: () {
                      chickIsRoleidAndNavigation(
                        navigateTo: () {
                          Get.to(() => AddListCategoryScreen());
                        },
                      );
                    },
                    title: "?????? ????????",
                    icon: "MAdd",
                  ),
                  const CustomMoreScreenDivider(),
                  CardMoreScreen(
                    onTap: () {
                      chickIsRoleidAndNavigation(navigateTo: () {
                        Get.to(() => const AddListClassifiedCategoryScreen());
                      });
                    },
                    title: "?????? ??????????",
                    icon: "MAddAds",
                  ),
                  const CustomMoreScreenDivider(),
                  CardMoreScreen(
                    onTap: () {
                      Get.to(() => const AboutScreen());
                    },
                    title: "???? ??????",
                    icon: "MHow2",
                  ),
                  const CustomMoreScreenDivider(),
                  CardMoreScreen(
                    onTap: () {
                      Get.to(() => const PrivacyPolicyScreen());
                    },
                    title: "?????????? ????????????????",
                    icon: "privacy",
                  ),
                  const CustomMoreScreenDivider(),
                  CardMoreScreen(
                    onTap: () {
                      Get.to(() => const ContactScreen());
                    },
                    title: "??????????",
                    icon: "support",
                  ),
                  if (SharedPrefController().isLogined) ...[
                    const CustomMoreScreenDivider(),
                    CardMoreScreen(
                      onTap: () async {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                              title: const Text('???? ?????? ????????????'),
                              content: const Text(
                                  '???????? ?????? ?????????? ???????? ?????????? ???? ?????? ?????????? ??'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('??????????',
                                      style: GoogleFonts.notoKufiArabic(
                                          textStyle: const TextStyle(
                                              color: AppColors.labelColor))),
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.red.shade700),
                                    ),
                                    onPressed: () async {
                                      if (SharedPrefController().isLogined) {
                                        await AuthApiController()
                                            .deleteAccount();
                                      }
                                    },
                                    child: Text('??????',
                                        style: GoogleFonts.notoKufiArabic())),
                              ]),
                        );
                      },
                      title: "?????? ??????????",
                      icon: "delete",
                    ),
                  ]
                ],
              ),
            ),

            // const Divider(),
            // ListTile(
            //   onTap: () {},
            //   leading: const Icon(Icons.settings),
            //   title: Text(
            //     '??????????',
            //     style: GoogleFonts.notoKufiArabic(
            //         textStyle: const TextStyle(
            //       color: Colors.black,
            //       fontSize: 12,
            //       fontWeight: FontWeight.w400,
            //     )),
            //   ),
            // ),
            const SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
  }

  void chickIsRoleidAndNavigation({required Function navigateTo}) {
    if (SharedPrefController().roleId == 3) {
      if (SharedPrefController().verifiedEmail != 'null') {
        navigateTo();
      } else {
        ShowMySnakbar(
            title: '???? ?????? ???????????? ??????????',
            message: '?????? ???????? ?????????? ?????????? ??????',
            backgroundColor: Colors.red.shade700);
      }
    } else if (SharedPrefController().roleId == 2) {
      alertDialogRoleAuthUser(context);
    } else {
      AlertDialogUnAuthUser(context);
    }
  }
}
