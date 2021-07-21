import 'package:sapiency_app/model/price/precision/price_with_precision.dart';
import 'package:sapiency_app/model/user/public/public_user.dart';

class CrowdsaleScreenState {
  final PublicUserInfluencer user;
  final Function() onContributePressed;
  final PriceWithPrecision raisedMoney;

  CrowdsaleScreenState({
    required this.user,
    required this.onContributePressed,
    required this.raisedMoney,
  });
}

CrowdsaleScreenState useCrowdsaleScreenState({required PublicUserInfluencer user, required Function() contribute}) {
  final crowdsale = user.crowdsaleOrNull!;

  return CrowdsaleScreenState(
    user: user,
    onContributePressed: contribute,
    //TODO move it to back
    raisedMoney: PriceWithPrecision(
      amount: crowdsale.sold.value.amount * crowdsale.price.amount,
      precision: crowdsale.price.precision,
      symbol: crowdsale.price.symbol,
    ),
  );
}
