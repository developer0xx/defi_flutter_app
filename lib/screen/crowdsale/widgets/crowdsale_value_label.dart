import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';

class CrowdsaleValueLabel extends StatelessWidget {
  final String value;
  final String label;

  CrowdsaleValueLabel({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: AppText.text.copyWith(
            fontWeight: FontWeight.normal,
            color: AppColors.textDarker,
          ),
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: AppText.text.copyWith(
            fontWeight: FontWeight.normal,
            height: 1.2,
            color: AppColors.textParagraph,
          ),
        ),
      ],
    );
  }
}
