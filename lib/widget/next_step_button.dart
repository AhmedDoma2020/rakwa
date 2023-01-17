import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main_elevated_button.dart';

class NextStepButton extends StatelessWidget {
  void Function()? onPressed;
  NextStepButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: MainElevatedButton(
          height: 38,
          width: 119,
          borderRadius: 29,
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'التالي',
                style: GoogleFonts.notoKufiArabic(
                    textStyle: const TextStyle(
                      color: Colors.white,
                        fontSize: 16, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.arrow_forward,
                size: 20,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
