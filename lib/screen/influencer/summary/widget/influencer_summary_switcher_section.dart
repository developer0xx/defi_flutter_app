import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/widgets/tile/app_switch_tile.dart';
import 'package:sapiency_app/screen/influencer/summary/state/influencer_summary_screen_state.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class InfluencerSummarySwitcherSection extends StatelessWidget {
  final InfluencerSummaryScreenState state;

  const InfluencerSummarySwitcherSection({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSwitchTile(
          state: state.confirmationSwitcherState,
          title: Text(
            context.strings.inf.summary.confirmation,
            style: AppText.text.copyWith(color: AppColors.textPrimary),
          ),
        ),
        AppSwitchTile(state: state.agreementSwitcherState, title: _buildAgreementText(context)),
      ],
    );
  }

  Widget _buildAgreementText(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: context.strings.inf.summary.terms1,
            style: AppText.text.copyWith(color: AppColors.textPrimary),
          ),
          TextSpan(
            text: context.strings.inf.summary.terms2,
            style: AppText.text.copyWith(color: AppColors.primary),
          ),
          TextSpan(
            text: context.strings.inf.summary.terms3,
            style: AppText.text.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
