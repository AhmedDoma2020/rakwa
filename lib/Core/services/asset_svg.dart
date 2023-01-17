import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AssetSvg extends StatelessWidget {
  final String imagePath;
  final Color? color;
  final double? height;
  final double? width;

  const AssetSvg({
    Key? key,
    required this.imagePath,
    this.color,
    this.height ,
    this.width ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/image/$imagePath.svg',
      color: color,
      width: width,
      height: height,
      fit: BoxFit.fill,
    );
  }
}


class IconSvg extends StatelessWidget {
  final String iconPath;
  final Color? color;
  final double? size;

  const IconSvg({
    Key? key,
    required this.iconPath,
    this.color,
    this.size ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$iconPath.svg',
      color: color,
      width: size,
      height: size,
      fit: BoxFit.fill,
      // matchTextDirection: true,
    );
  }
}
