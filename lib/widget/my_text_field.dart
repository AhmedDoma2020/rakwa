import 'package:flutter/material.dart';

import '../app_colors/app_colors.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  void Function(String)? onChanged;
  final int? hintMaxLines;
  final int? maxLines;
  final FocusNode? focusNode;
  final bool? enabled;
  final String? helperText;

  MyTextField(
      {required this.hint,
      required this.controller,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.prefixIcon,
      this.suffixIcon,
      this.onChanged,
      this.hintMaxLines,
      this.maxLines,
      this.focusNode,
      this.helperText,
      this.enabled});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0),
                color: AppColors.labelColor.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5),
          ]),
      child: TextField(
        
        enabled: enabled,
        focusNode: focusNode,
        maxLines: maxLines,
        onChanged: onChanged,
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
        cursorColor: AppColors.mainColor,
        decoration: InputDecoration(
          helperText:helperText ,
          hintMaxLines: hintMaxLines,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
