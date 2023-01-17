import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/widget/SVG_Widget/svg_widget.dart';
import '../app_colors/app_colors.dart';

class CategoryWidget extends StatelessWidget {
  final String categoryName;
  final String? image;
  final int index;
  final bool isMore;

  List colors = const [
    Color.fromARGB(255, 224, 20, 81),
    Color.fromARGB(255, 45, 106, 228),
    Color.fromARGB(255, 159, 6, 254),
    Color.fromARGB(255, 219, 242, 12),
    Color.fromARGB(255, 224, 20, 81),
    Color.fromARGB(255, 45, 106, 228),
    Color.fromARGB(255, 159, 6, 254),
    Color.fromARGB(255, 219, 242, 12)
  ];

  CategoryWidget(
      {required this.categoryName,
      required this.image,
      this.index = 1,
      this.isMore = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !isMore
              ? image != null && image!.isNotEmpty
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                        'https://www.rakwa.com/laravel_project/public/storage/category/${image!}',
                        height: 45,
                        width: 45,
                      fit: BoxFit.cover,
                      errorBuilder:(context, error, stackTrace) => const Icon(Icons.category) ,
                      ),
                    )
                  : const Icon(Icons.category)
              : const IconSvg(
                  "more",
                  size: 32,
                ),
          const SizedBox(
            height: 4,
          ),
          Text(
            categoryName,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.notoKufiArabic(
                textStyle:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w400)),
          )
        ],
      ),
    );
  }
}