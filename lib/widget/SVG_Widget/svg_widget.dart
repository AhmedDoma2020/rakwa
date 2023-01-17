import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakwa/app_colors/app_colors.dart';

class AssetSvg extends StatelessWidget {
  final String imagePath;
  final Color? color;
  final double? height;
  final double? width;
  final BoxFit fit;

  const AssetSvg(
    this.imagePath, {
    Key? key,
    this.color,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'images/$imagePath.svg',
      color: color,
      width: width,
      height: height,
      fit: fit,
    );
  }
}

class IconPng extends StatelessWidget {
  final String imagePath;
  final Color? color;
  final double? size;
  final BoxFit fit;

  const IconPng(
    this.imagePath, {
    Key? key,
    this.color,
    this.size,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/$imagePath.png',
      color: color,
      height: size,
      width: size,
    );
  }
}

class IconSvg extends StatelessWidget {
  final String iconPath;
  final Color? color;
  final double size;
  final double? width;
  final double? height;
  final BoxFit fit;

  const IconSvg(
    this.iconPath, {
    Key? key,
    this.color = AppColors.mainColor,
    this.size = 14,
    this.width,
    this.height,
    this.fit = BoxFit.fill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'images/$iconPath.svg',
      color: color,
      width: width == null ? size.w : width!.w,
      height: height == null ? size.w : height!.h,
      fit: fit,
      // matchTextDirection: true,
    );
  }
}
