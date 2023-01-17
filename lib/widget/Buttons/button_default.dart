import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/widget/Buttons/base_button.dart';



enum ButtonStyle { withBorder, withOutBorder }

class ButtonDefault extends StatelessWidget {
  final String title;
  final String iconImage;
  final Color buttonColor;
  final Color disActiveButtonColor;
  final Color disActiveButtonTitleColor;
  final Color titleColor;
  final Color iconColor;
  final VoidCallback? onTap;
  final double height;
  final double width;
  final double radius;
  final double titleSize;
  final double iconHeight;
  final Color? borderColor;
  final Color disActiveBorderColor;
  final bool active;
  final Widget? child;
  final bool isLoading;

  const ButtonDefault({
    super.key,
    this.isLoading = false,
    this.child,
    this.borderColor,
    this.disActiveButtonColor = Colors.white,
    this.disActiveButtonTitleColor = AppColors.disActiveButtonTitle,
    this.disActiveBorderColor = Colors.transparent,
    this.titleSize = 17,
    this.iconHeight = 12,
    this.radius = kNButtonRadius,
    this.title = '',
    this.iconImage = '',
    this.buttonColor = AppColors.mainColor,
    this.titleColor = Colors.white,
    this.iconColor = AppColors.mainColor,
    this.onTap,
    this.height = 48,
    this.width = double.infinity,
    this.active = true,
  });

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      height: height.h,
      width: width.w,
      radius: radius.r,
      borderColor: active ? borderColor : disActiveBorderColor,
      buttonColor: active ? buttonColor : disActiveButtonColor,
      onTap: active
          ? () {
              onTap!();
            }
          : () {},
      child: child ?? drawChild(active),
    );
  }

  Widget drawChild(bool active) {
    if (title.isNotEmpty && iconImage.isEmpty) {
      // TODO return text only
      return Center(
        child:
        Text(
          title,
          style: GoogleFonts.notoKufiArabic(
            textStyle:  TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: active ? titleColor : disActiveButtonTitleColor.withOpacity(.9),
            ),
          ),
          textAlign: TextAlign.end,
        ),

      );
    } else if (title.isEmpty && iconImage.isNotEmpty) {
      // TODO return icon only
      return Center(
          child: Image.asset(
        'assets/icons/$iconImage',
        color: iconColor,
        height: iconHeight,
      ));
    } else if (title.isNotEmpty && iconImage.isNotEmpty) {
      // TODO return icon and text
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.notoKufiArabic(
                textStyle:  TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  color: active ? titleColor : disActiveButtonTitleColor.withOpacity(.9),
                ),
              ),
              textAlign: TextAlign.end,
            ),
            const SizedBox(width: 7.0),
            isLoading
                ? SizedBox(
                    height: 12.h,
                    width: 12.h,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.w,
                    ),
                  )
                : Image.asset(
                    'assets/icons/$iconImage',
                    color: iconColor,
                    height: iconHeight,
                  )
          ],
        ),
      );
    } else {
      // TODO return text only
      return Center(
        child:  Text(
          title,
          style: GoogleFonts.notoKufiArabic(
            textStyle:  TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: active ? titleColor : disActiveButtonTitleColor.withOpacity(.9),
            ),
          ),
          textAlign: TextAlign.end,
        ),
      );
    }
  }
}
