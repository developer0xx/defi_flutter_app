import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';

class AppLink extends StatelessWidget {
  final String label;
  final double fontSize;
  final Function() onTap;

  AppLink({
    required this.label,
    this.fontSize = 14,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        child: Text(
          label,
          style: AppText.text.copyWith(
            fontSize: fontSize,
            color: AppColors.primary,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
