import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/screen/influencer/flow/influencer_flow.dart';
import 'package:sapiency_app/util/extension/list_extensions.dart';

class InfluencerProgressBar extends StatelessWidget {
  final int step;
  final String title;

  const InfluencerProgressBar({
    Key? key,
    required this.step,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 30),
      child: Row(
        children: [
          ...[for (int i = 0; i < step; i++) _buildText(i + 1)].separatedWith(
            _buildSeparator(AppColors.primary),
          ),
          _buildTitle(),
          ...[for (int i = step; i < InfluencerFlow.stepQuantity; i++) _buildText(i + 1)].separatedWith(
            _buildSeparator(AppColors.textParagraph),
          ),
        ],
      ),
    );
  }

  Widget _buildText(int index) {
    return Text(
      index < 10 ? '0$index' : '$index',
      style: AppText.label.copyWith(
        color: index <= step ? AppColors.primary : AppColors.textParagraph,
      ),
    );
  }

  Widget _buildSeparator(Color color) {
    return Text(
      ' - ',
      style: AppText.label.copyWith(
        color: color,
      ),
    );
  }

  Widget _buildTitle() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Text(
          title,
          style: AppText.label.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
