
import 'package:flutter/material.dart';


class BaseSliderWidget extends StatelessWidget {
  final Widget widget;

  const BaseSliderWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(
            width: 16,
          ),
          widget,
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }
}
