import 'package:flutter/material.dart';
import 'package:rakwa/app_colors/app_colors.dart';

class RateStarsWidget extends StatelessWidget {
  final double? rate;
  final bool padding;
  RateStarsWidget({required this.rate, this.padding = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DisplayRateWidget(
            isRated: rate == null
                ? false
                : rate! >= 1
                    ? true
                    : false,
            padding: padding),
        DisplayRateWidget(
            isRated: rate == null
                ? false
                : rate! >= 2
                    ? true
                    : false,
            padding: padding),
        DisplayRateWidget(
            isRated: rate == null
                ? false
                : rate! >= 3
                    ? true
                    : false,
            padding: padding),
        DisplayRateWidget(
            isRated: rate == null
                ? false
                : rate! >= 4
                    ? true
                    : false,
            padding: padding),
        DisplayRateWidget(
            isRated: rate == null
                ? false
                : rate! >= 5
                    ? true
                    : false,
            padding: padding),
      ],
    );
  }
}

class DisplayRateWidget extends StatelessWidget {
  final bool isRated;
  final double size;
  final bool padding;

  DisplayRateWidget(
      {required this.isRated, this.size = 16, this.padding = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ? const EdgeInsets.all(2.5) : const EdgeInsets.all(1),
      margin: const EdgeInsets.only(left: 2.5),
      decoration: BoxDecoration(
        color: isRated ? AppColors.mainColor : Color.fromARGB(255, 68, 65, 65),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Icon(
        Icons.star,
        color: Colors.white,
        size: size,
      ),
    );
  }
}
