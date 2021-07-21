import 'package:flutter/material.dart';
import 'package:sapiency_app/common/widgets/crowdsale_progress_bar.dart';
import 'package:sapiency_app/common/widgets/input/date_input/date_input_helper.dart';
import 'package:sapiency_app/model/crowdsale/crowdsale.dart';
import 'package:sapiency_app/model/user/public/public_user.dart';
import 'package:sapiency_app/screen/crowdsale/state/crowdsale_screen_state.dart';
import 'package:sapiency_app/screen/crowdsale/widgets/crowdsale_raised_text.dart';

import 'crowdsale_days_left.dart';
import 'crowdsale_raised_percentage_text.dart';

class CrowdsaleDetailsProgress extends StatelessWidget {
  final CrowdsaleScreenState state;

  const CrowdsaleDetailsProgress({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isCrowdsaleUpcoming = DateHelper.isCrowdsaleUpcoming(state.user.influencer.crowdsale!.timeLeft);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isCrowdsaleUpcoming) _buildTop(isCrowdsaleUpcoming),
        _buildBottom(isCrowdsaleUpcoming, context),
      ],
    );
  }

  Widget _buildTop(bool isCrowdsaleUpcoming) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CrowdsaleRaisedText(user: state.user),
        SizedBox(height: 12),
        CrowdsaleProgressBar(
          percentRaised: state.user.crowdsaleOrNull!.sold.percent,
        ),
        SizedBox(height: 12),
      ],
    );
  }

  Widget _buildBottom(bool isCrowdsaleUpcoming, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        alignment: !isCrowdsaleUpcoming ? WrapAlignment.spaceBetween : WrapAlignment.center,
        children: [
          if (!isCrowdsaleUpcoming) ...[
            CrowdsaleRaisedPercentageText(user: state.user),
            SizedBox(height: 32, width: 16),
            Spacer(),
          ],
          CrowdsaleDaysLeft(daysLeft: DateHelper.timeLeftFromDuration(state.user.crowdsaleOrNull!.timeLeft, context)),
        ],
      ),
    );
  }
}
