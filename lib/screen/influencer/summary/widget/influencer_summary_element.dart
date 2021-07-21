import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';

class InfluencerSummaryElement extends StatelessWidget {
  final String title;
  final String? subtitle;

  const InfluencerSummaryElement({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppText.label.copyWith(color: AppColors.textParagraph)),
            Text(subtitle ?? '-', style: AppText.text2),
          ],
        ),
      ),
    );
  }
}

class InfluencerSummaryTwoElements extends StatelessWidget {
  final Widget elementLeft;
  final Widget elementRight;

  const InfluencerSummaryTwoElements({
    Key? key,
    required this.elementRight,
    required this.elementLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(child: elementLeft),
        Flexible(child: elementRight),
      ],
    );
  }
}
