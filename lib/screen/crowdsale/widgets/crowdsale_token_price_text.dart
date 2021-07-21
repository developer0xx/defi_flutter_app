import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/model/crowdsale/crowdsale.dart';
import 'package:sapiency_app/model/user/public/public_user.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class CrowdsaleTokenPriceText extends StatelessWidget {
  final PublicUserInfluencer user;

  CrowdsaleTokenPriceText({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          user.crowdsaleOrNull!.price.toCashDisplay(),
          style: AppText.text.copyWith(
            fontWeight: FontWeight.bold,
            height: 1.2,
            color: AppColors.primary,
          ),
        ),
        Text(
          context.strings.crowdsale.tokenPrice,
          style: AppText.label.copyWith(
            fontWeight: FontWeight.normal,
            height: 1.2,
            color: AppColors.textParagraph,
          ),
        )
      ],
    );
  }
}
