import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';

class CrowdsaleProgressBar extends StatelessWidget {
  final double percentRaised;

  const CrowdsaleProgressBar({
    Key? key,
    required this.percentRaised,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Flexible(
            flex: (percentRaised).toInt(),
            child: Container(
              height: 8,
              color: AppColors.accent,
            ),
          ),
          Flexible(
            flex: (100 - percentRaised).toInt(),
            child: Container(
              height: 8,
              width: double.infinity,
              color: AppColors.lightest,
            ),
          ),
        ],
      ),
    );
  }
}
