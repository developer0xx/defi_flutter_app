import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/constants/app_values.dart';

class InfluencerCrowdsaleInfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfluencerCrowdsaleInfoCard({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: AppValues.smallBorderRadius),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title, style: AppText.label),
                Spacer(),
                ClipOval(child: Container(height: 12, width: 12, color: AppColors.light)),
              ],
            ),
            SizedBox(height: 4),
            Text(content, style: AppText.tileTitle.copyWith(fontWeight: FontWeight.w100)),
          ],
        ),
      ),
    );
  }
}
