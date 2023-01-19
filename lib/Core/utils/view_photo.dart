import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:rakwa/Core/utils/extensions.dart';

class ViewPhoto extends StatelessWidget {
  final List<String> photos;

  const ViewPhoto({Key? key, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      child: PageView(
        children: photos
            .map(
              (e) => PhotoView(
                imageProvider: NetworkImage(e),
              ),
            )
            .toList(),
      ),
    );
  }
}
