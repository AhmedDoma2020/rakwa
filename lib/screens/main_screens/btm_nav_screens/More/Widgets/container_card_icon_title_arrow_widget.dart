
import 'package:flutter/material.dart';

class ContainerCardIconTitleArrowWidget extends StatelessWidget {
  final Widget widget;
  const ContainerCardIconTitleArrowWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: themeData.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: widget,
      ),
    );
  }
}