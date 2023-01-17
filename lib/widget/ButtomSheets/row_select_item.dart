import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/app_colors/app_colors.dart';

class RowSelectItem extends StatelessWidget {
  const RowSelectItem({
    Key? key,
    required this.onTap,
    required this.title,
    required this.active,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.notoKufiArabic(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                    ),
                  )
              ),
              SingleChoiceWidget(active: active),
            ],
          ),
        ),
      ),
    );
  }
}

class SingleChoiceWidget extends StatelessWidget {
  const SingleChoiceWidget({
    Key? key,
    required this.active,
  }) : super(key: key);

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26.w,
      width: 26.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
        active ? AppColors.mainColor : AppColors.mainColor.withOpacity(.1),
        border: Border.all(
          color: AppColors.mainColor,
          width: 1.w,
        ),
      ),
      child: active
          ?  Icon(
        Icons.check,
        size: 20.w,
        color: Colors.white,
      )
          : 0.ESH(),
    );
  }
}
