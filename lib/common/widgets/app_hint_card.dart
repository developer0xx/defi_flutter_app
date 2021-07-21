import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/constants/app_values.dart';

class AppHintCard extends StatelessWidget {
  final String text;

  AppHintCard(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Material(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: AppValues.smallBorderRadius),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildIcon(context),
              Expanded(child: _buildTitle(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        text,
        style: AppText.text.copyWith(
          fontSize: 12,
          color: AppColors.grey,
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SvgPicture.asset(AppImages.hintIcon),
    );
  }
}
