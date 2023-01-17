import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:rakwa/api/api_controllers/contact_about_api_controller.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/model/about_model.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarDefault(title: "من نحن"),
      body: FutureBuilder<AboutModel?>(
        future: ContactAboutApiController().getAbout(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ),
            );
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  _parseHtmlString(snapshot.data!.data!),
                  style: GoogleFonts.notoKufiArabic(
                      textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  )),
                ),
              ),
            );
          } else {
            return const Text(
              'من نحن',
            );
          }
        },
      ),
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }
}