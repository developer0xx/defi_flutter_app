import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/widgets/input/date_input/date_input_helper.dart';
import 'package:sapiency_app/common/widgets/tags/metatags_display.dart';
import 'package:sapiency_app/model/user/public/public_user.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class CrowdsaleDetailsGrid extends StatelessWidget {
  final PublicUserInfluencer user;

  const CrowdsaleDetailsGrid({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildLeftColumn(context),
            Spacer(),
            _buildRightColumn(context),
            Spacer(),
          ],
        ),
        _buildTags(context),
      ],
    );
  }

  Widget _buildLeftColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCell(context.strings.crowdsale.title.supply, "21,000,000 " + user.influencer.token),
        _buildCell(context.strings.crowdsale.title.hardcap, user.crowdsaleOrNull!.toRaise.toCashDisplay()),
        _buildCell(context.strings.crowdsale.title.tokensForSale, user.crowdsaleOrNull!.toSale.toTokenDisplay())
      ],
    );
  }

  Widget _buildRightColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCell(context.strings.crowdsale.title.crowdsale, context.strings.crowdsale.crowdsale.active),
        _buildCell(
          context.strings.crowdsale.title.startDate,
          DateHelper.formatDMY.format(user.crowdsaleOrNull!.startDate.toLocal()),
        ),
        _buildCell(
          context.strings.crowdsale.title.endDate,
          DateHelper.formatDMY.format(user.crowdsaleOrNull!.endDate.toLocal()),
        ),
      ],
    );
  }

  Widget _buildCell(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        _buildValue(value),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildTags(BuildContext context) {
    return MetatagsDisplay(
      tags: user.influencer.metaTags,
      labelColor: AppColors.textPrimary,
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: AppText.label.copyWith(
        fontWeight: FontWeight.normal,
        color: AppColors.textParagraph,
      ),
    );
  }

  Widget _buildValue(String value) {
    return Text(
      value,
      style: AppText.text.copyWith(
        fontWeight: FontWeight.normal,
        color: AppColors.textDarker,
      ),
    );
  }
}
