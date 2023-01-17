import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors/app_colors.dart';

class WorkHourWidget extends StatelessWidget {
  final String day;
  final bool isChecked;
  final Widget amChild;
  final Widget pmChild;
  void Function(bool?)? onChanged;
  void Function()? onTapPm;
  void Function()? onTapAm;

  WorkHourWidget(
      {required this.day,
      required this.isChecked,
      required this.onChanged,
      required this.amChild,
      required this.pmChild,
      required this.onTapAm,
      required this.onTapPm});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 48,
          width: 106,
          decoration:
              BoxDecoration(border: Border.all(color: AppColors.subTitleColor.withOpacity(0.3))),
          child: Row(
            children: [
              Checkbox(
                fillColor: MaterialStateProperty.all(
                    isChecked ? AppColors.mainColor : AppColors.subTitleColor),
                shape: const CircleBorder(),
                value: isChecked,
                onChanged: onChanged,
              ),
              Text(day,style: GoogleFonts.notoKufiArabic(
                      textStyle:const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )
                    ),),
            ],
          ),
        ),
        InkWell(
          onTap: onTapAm,
          child: Container(
              alignment: Alignment.center,
              height: 48,
              width: 106,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.subTitleColor.withOpacity(0.3))),
              child: amChild),
        ),
        InkWell(
          onTap: onTapPm,
          child: Container(
              alignment: Alignment.center,
              height: 48,
              width: 106,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.subTitleColor.withOpacity(0.3))),
              child: pmChild),
        ),
      ],
    );
  }
}
