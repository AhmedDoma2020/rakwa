
import 'package:flutter/material.dart';

class CustomMoreScreenDivider extends StatelessWidget {
  final Color color;
  const CustomMoreScreenDivider({
    Key? key,  this.color=Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Divider(
      color: color,
      height: 2,
      thickness: 2,
    );
  }
}