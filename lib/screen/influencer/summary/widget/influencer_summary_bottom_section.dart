import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/screen/influencer/flow/influencer_flow_state.dart';
import 'package:sapiency_app/screen/influencer/summary/state/influencer_summary_screen_state.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

import 'influencer_summary_element.dart';

class InfluencerSummaryBottomSection extends StatelessWidget {
  final InfluencerSummaryScreenState state;

  const InfluencerSummaryBottomSection({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: AppValues.smallBorderRadius),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfluencerSummaryElement(
                title: context.strings.inf.summary.crowdsaleTitle,
                subtitle: state.crowdsale!.title,
              ),
              InfluencerSummaryElement(
                title: context.strings.inf.summary.crowdsaleDescription,
                subtitle: state.crowdsale!.description,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
