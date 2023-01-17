import 'package:flutter/material.dart';
import 'package:steps_indicator/steps_indicator.dart';

import '../app_colors/app_colors.dart';

class StepsWidget extends StatelessWidget {
  final int selectedStep;

  StepsWidget({required this.selectedStep});

  @override
  Widget build(BuildContext context) {
    return StepsIndicator(
      selectedStep: selectedStep,
      doneStepSize: 18,
      selectedStepSize: 18,
      unselectedStepSize: 18,
      nbSteps: 7,
      undoneLineColor: AppColors.subTitleColor,
      selectedStepColorIn: Colors.white,
      unselectedStepColorOut: AppColors.subTitleColor,
      unselectedStepColorIn: Colors.white,
      selectedStepColorOut: AppColors.mainColor,
      doneStepColor: AppColors.mainColor,
      doneLineColor: AppColors.mainColor,
    );
  }
}