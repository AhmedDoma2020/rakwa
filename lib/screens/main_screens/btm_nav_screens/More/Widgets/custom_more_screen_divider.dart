
import 'package:flutter/material.dart';

class CustomMoreScreenDivider extends StatelessWidget {
  const CustomMoreScreenDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.white,
      height: 2,
      thickness: 2,
    );
  }
}