import 'package:flutter/material.dart';

import '../app_colors/app_colors.dart';

class MainElevatedButton extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final bool borderSide;
  void Function()? onPressed;

  MainElevatedButton(
      {required this.child,
      required this.height,
      required this.width,
      required this.borderRadius,
      required this.onPressed,
      this.borderSide = false,
      this.backgroundColor = AppColors.mainColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              side: borderSide
                  ?const BorderSide(color: AppColors.mainColor)
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius))),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          fixedSize: MaterialStateProperty.all(Size(width, height)),
        ),
        onPressed: onPressed,
        child: child);
  }
}
