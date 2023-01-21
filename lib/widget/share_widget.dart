
import 'package:flutter/material.dart';
import 'package:rakwa/Core/utils/dynamic_link_service.dart';

class ShareItemWidget extends StatelessWidget  {
  final String id;
  final String kayType;

  const ShareItemWidget({
    Key? key,
    required this.id, required this.kayType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(0.4),
        child: IconButton(
            onPressed: () async{
              await DynamicLink().createDynamicLink(false, id);
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
