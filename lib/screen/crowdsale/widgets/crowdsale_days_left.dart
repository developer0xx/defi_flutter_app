import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/localization/localization.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class CrowdsaleDaysLeft extends StatelessWidget {
  final String daysLeft;

  const CrowdsaleDaysLeft({Key? key, required this.daysLeft}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.accent),
        ),
        SizedBox(width: 6),
        Text(
          daysLeft,
          style: AppText.text.copyWith(
            fontWeight: FontWeight.normal,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}
