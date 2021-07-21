import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/common/widgets/input/date_input/date_input_helper.dart';
import 'package:sapiency_app/common/widgets/tags/metatags_display.dart';
import 'package:sapiency_app/screen/influencer/summary/state/influencer_summary_screen_state.dart';
import 'package:sapiency_app/util/extension/extensions.dart';

import 'influencer_summary_element.dart';

class InfluencerSummaryTopSection extends StatelessWidget {
  final InfluencerSummaryScreenState state;

  const InfluencerSummaryTopSection({
    Key? key,
    required this.state,
  }) : super(key: key);

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
              InfluencerSummaryTwoElements(
                elementLeft: InfluencerSummaryElement(
                  title: context.strings.inf.summary.tokenName,
                  subtitle: state.influencer.tokenName,
                ),
                elementRight: InfluencerSummaryElement(
                  title: context.strings.inf.summary.symbol,
                  subtitle: state.influencer.token,
                ),
              ),
              InfluencerSummaryTwoElements(
                elementLeft: InfluencerSummaryElement(
                  title: context.strings.inf.summary.totalSupply,
                  subtitle: "21,000,000 ${state.influencer.token}",
                ),
                elementRight: InfluencerSummaryElement(
                  title: context.strings.inf.summary.decimal,
                  subtitle: '4',
                ),
              ),
              InfluencerSummaryElement(
                title: context.strings.inf.summary.tokenFee,
                subtitle: "210,000 ${state.influencer.token}",
              ),
              InfluencerSummaryElement(
                title: context.strings.inf.summary.crowdsale,
                subtitle:
                    state.crowdsale != null ? context.strings.inf.summary.active : context.strings.inf.summary.inactive,
              ),
              InfluencerSummaryElement(
                title: context.strings.inf.summary.crowdsaleHardcap,
                subtitle: state.crowdsale?.toRaise?.toCashDisplay(),
              ),
              InfluencerSummaryTwoElements(
                elementLeft: InfluencerSummaryElement(
                  title: context.strings.inf.summary.liquidityFee,
                  subtitle: state.crowdsale?.toRaise
                      ?.let((it) => it.copyWith(amount: it.amount / Decimal.fromInt(10)))
                      .toTokenDisplay(),
                ),
                elementRight: InfluencerSummaryElement(
                  title: context.strings.inf.summary.crowdsaleFee,
                  subtitle: state.crowdsale?.toRaise
                      ?.let((it) => it.copyWith(amount: it.amount / Decimal.fromInt(5)))
                      .toTokenDisplay(),
                ),
              ),
              InfluencerSummaryElement(
                title: context.strings.inf.summary.tokensForSale,
                subtitle: state.crowdsale?.toSale?.toTokenDisplay(),
              ),
              InfluencerSummaryElement(
                title: context.strings.inf.summary.tokenPrice,
                subtitle: state.crowdsaleComputedData?.price?.toCashDisplay(),
              ),
              InfluencerSummaryTwoElements(
                elementLeft: InfluencerSummaryElement(
                  title: context.strings.inf.summary.startDate,
                  subtitle: state.crowdsale?.startDate?.let((it) => DateHelper.formatDMY.format(it)),
                ),
                elementRight: InfluencerSummaryElement(
                  title: context.strings.inf.summary.endDate,
                  subtitle: state.crowdsaleComputedData?.endDate?.let((it) => DateHelper.formatDMY.format(it)),
                ),
              ),
              MetatagsDisplay(tags: state.influencer.metaTags!),
            ],
          ),
        ),
      ),
    );
  }
}
