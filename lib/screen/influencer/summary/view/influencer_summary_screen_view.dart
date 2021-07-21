import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sapiency_app/common/widgets/submit/submit_wrapper.dart';
import 'package:sapiency_app/screen/influencer/summary/widget/influencer_summary_bottom_section.dart';
import 'package:sapiency_app/screen/influencer/summary/widget/influencer_summary_switcher_section.dart';
import 'package:sapiency_app/screen/influencer/summary/widget/influencer_summary_top_section.dart';
import 'package:sapiency_app/screen/influencer/widget/influencer_view_layout.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';
import '../influencer_summary_screen.dart';
import '../state/influencer_summary_screen_state.dart';

class InfluencerSummaryScreenView extends StatelessWidget {
  final InfluencerSummaryScreenState state;

  const InfluencerSummaryScreenView({required this.state});

  //TODO remove mock ups
  @override
  Widget build(BuildContext context) {
    return SubmitWrapper(
      state: state.submitState,
      child: InfluencerViewLayout(
        title: context.strings.inf.summary.title,
        subtitle: context.strings.inf.summary.subtitle,
        progressTitle: context.strings.inf.summary.progressTitle,
        step: InfluencerSummaryScreen.step,
        child: _buildContent(context),
        onProceed: state.submitState.onSubmitPressed,
        buttonEnabled: state.isButtonEnabled,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        InfluencerSummaryTopSection(state: state),
        SizedBox(height: 12),
        if (state.crowdsale != null) _buildBottomSection(),
        InfluencerSummarySwitcherSection(state: state),
      ],
    );
  }

  Widget _buildBottomSection() {
    return Column(
      children: [
        InfluencerSummaryBottomSection(state: state),
        SizedBox(height: 12),
      ],
    );
  }
}
