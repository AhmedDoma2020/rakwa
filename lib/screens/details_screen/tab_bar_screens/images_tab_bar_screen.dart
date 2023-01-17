import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagesTabBarScreen extends StatefulWidget {
  final String? itemImageMedium;
  final String? itemImageSmall;
  final String? itemImageTiny;
  final String? itemImageBlur;

  ImagesTabBarScreen(
      {this.itemImageBlur,
      this.itemImageMedium,
      this.itemImageSmall,
      this.itemImageTiny});

  @override
  State<ImagesTabBarScreen> createState() => _ImagesTabBarScreenState();
}

class _ImagesTabBarScreenState extends State<ImagesTabBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.itemImageSmall != null &&
          widget.itemImageMedium != null &&
          widget.itemImageBlur != null &&
          widget.itemImageTiny != null,
      replacement: Center(
        child: Image.asset('images/noimages.png'),
      ),
      child: ListView(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
        physics: const BouncingScrollPhysics(),
        children: [
          Visibility(
            visible: widget.itemImageMedium != null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://www.rakwa.com/laravel_project/public/storage/item/${widget.itemImageMedium}',
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Visibility(
            visible: widget.itemImageSmall != null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://www.rakwa.com/laravel_project/public/storage/item/${widget.itemImageSmall}',
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Visibility(
            visible: widget.itemImageTiny != null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://www.rakwa.com/laravel_project/public/storage/item/${widget.itemImageTiny}',
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Visibility(
            visible: widget.itemImageBlur != null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://www.rakwa.com/laravel_project/public/storage/item/${widget.itemImageBlur}',
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
