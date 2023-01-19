import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:rakwa/Core/utils/view_photo.dart';
import 'package:rakwa/model/details_model.dart';
import 'package:rakwa/widget/photo_view.dart';

class GalleryScreen extends StatefulWidget {
  final List<Galleries> galleries;
  GalleryScreen({required this.galleries});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        bottom: false,
        child: AnimationLimiter(
          child: GridView.builder(
            padding: EdgeInsets.zero,

            itemCount: widget.galleries.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 7),
            itemBuilder: (context, index) {
              List<String> photos = [];
              for (var item
              in widget.galleries) {
                photos.add(
                    'https://www.rakwa.com/laravel_project/public/storage/item/gallery/${item.itemImageGalleryName}');
              }
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: widget.galleries.length,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child:  InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: (){
                        Get.to(
                              () => ViewPhoto(
                            photos: photos,
                          ),
                        );
                        },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                            'https://www.rakwa.com/laravel_project/public/storage/item/gallery/${widget.galleries[index].itemImageGalleryName}',fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
