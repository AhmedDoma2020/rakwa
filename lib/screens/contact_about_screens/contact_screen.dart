import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/api/api_controllers/contact_about_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/model/contact_model.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarDefault(title: "الدعم"),


      body: FutureBuilder<List<ContactModel>>(
        future: ContactAboutApiController().getContact(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.separated(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data![index].faqsQuestion!,
                          style: GoogleFonts.notoKufiArabic(
                              textStyle: const TextStyle(
                            color: Colors.black,
                          )),
                        ),
                        const SizedBox(height: 12,),
                        Text(
                          snapshot.data![index].faqsAnswer!,
                          style: GoogleFonts.notoKufiArabic(
                              textStyle: const TextStyle(
                            color: AppColors.describtionLabel,
                          )),
                        ),
                      ],
                    ));
              },
            );
          } else {
            return const Text('الدعم');
          }
        },
      ),
    );
  }
}