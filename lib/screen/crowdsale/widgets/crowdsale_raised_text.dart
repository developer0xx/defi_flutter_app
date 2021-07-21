import 'package:flutter/material.dart';
import 'package:sapiency_app/model/crowdsale/crowdsale.dart';
import 'package:sapiency_app/model/user/public/public_user.dart';
import 'package:sapiency_app/util/extension/decimal_extension.dart';
import 'crowdsale_value_label.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class CrowdsaleRaisedText extends StatelessWidget {
  final PublicUserInfluencer user;

  const CrowdsaleRaisedText({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final crowdsale = user.crowdsaleOrNull!;
    return CrowdsaleValueLabel(
      //TODO check what is amount
      value: crowdsale.price.copyWith(amount: crowdsale.sold.value.amount * crowdsale.price.amount).toCashDisplay(),
      label: context.strings.crowdsale.raised,
    );
  }
}
