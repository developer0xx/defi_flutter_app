import 'package:flutter/material.dart';
import 'package:sapiency_app/model/user/public/public_user.dart';
import 'package:sapiency_app/screen/crowdsale/widgets/crowdsale_value_label.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class CrowdsaleRaisedPercentageText extends StatelessWidget {
  final PublicUserInfluencer user;

  const CrowdsaleRaisedPercentageText({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final crowdsale = user.crowdsaleOrNull!;
    return CrowdsaleValueLabel(
      value: "${crowdsale.sold.percent.round()}%",
      label: context.strings.crowdsale.amountFrom(
        raised: crowdsale.sold.value.amount.toString(),
        cap: crowdsale.toSale.amount.toString(),
        token: crowdsale.toSale.symbol,
      ),
    );
  }
}
