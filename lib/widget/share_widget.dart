
import 'package:flutter/material.dart';
import 'package:rakwa/Core/utils/dynamic_link_service.dart';

class ShareItemWidget extends StatelessWidget  {
  final String id;
  final String kayType;
  final String title;
  final String description;
  final String image;

  const ShareItemWidget({
    Key? key,
    required this.id, required this.kayType, required this.title, required this.description, required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(0.4),
        child: IconButton(
            onPressed: () async{
              await DynamicLink().createDynamicLink(id: id,short: false,title: title,image: image,description: description,);
            },
            icon: const Icon(
              Icons.share_outlined,
              // Icons.bookmark_outlined,
              color: Colors.white,
            )),
      ),
    );
  }


}
