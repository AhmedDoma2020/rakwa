import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/model/artical_model.dart';
import 'package:html/parser.dart';
import 'package:rakwa/screens/details_screen/details_screen.dart';

class OneArticalScreen extends StatefulWidget {
  final ArticalModel articalModel;

  OneArticalScreen({required this.articalModel});

  @override
  State<OneArticalScreen> createState() => _OneArticalScreenState();
}

class _OneArticalScreenState extends State<OneArticalScreen> {
  var text;

  @override
  void initState() {
    super.initState();
    text = _parseHtmlString(widget.articalModel.body!);
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 232,
            pinned: true,
            stretch: true,
            backgroundColor: Colors.black12,
            leadingWidth: 80,
            leading: const LeadingSliverAppBarIconDetailsScreen(),
            flexibleSpace: FlexibleSpaceBar(
              background: SizedBox(
                height: 232,
                width: Get.width,
                child: Image.network(
                  'https://www.rakwa.com/laravel_project/public${widget.articalModel.featuredImage}',
                  height: 232,
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                AnimationLimiter(
                  child: Column(
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 375),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: SizedBox(
                            height: 20,
                            child: Row(
                              children: [
                                const VerticalDivider(
                                  color: AppColors.mainColor,
                                  thickness: 1,
                                ),
                                Text(
                                  widget.articalModel.publishedAt!.toString(),
                                  style: GoogleFonts.tajawal(
                                      textStyle: const TextStyle(
                                    color: AppColors.viewAllColor,
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            widget.articalModel.title!,
                            style: GoogleFonts.notoKufiArabic(
                                textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            )),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 10),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Text(
                              text,
                              style: GoogleFonts.notoKufiArabic(
                                color: AppColors.describtionLabel,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
