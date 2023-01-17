import 'package:flutter/material.dart';

import '../app_colors/app_colors.dart';

class TextFieldCodeWidget extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  Function(String)? onChanged;

  TextFieldCodeWidget(
      {required this.focusNode,
      required this.textEditingController,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 60,
      alignment: Alignment.center,
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
        controller: textEditingController,
        textAlign: TextAlign.center,
        onChanged: onChanged,
        focusNode: focusNode,
        maxLength: 1,
        
        keyboardType: TextInputType.number,
        cursorColor: AppColors.mainColor,
        decoration: InputDecoration(
         counterText: "",
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(width: 1, color: AppColors.subTitleColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(width: 1, color: AppColors.mainColor)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
