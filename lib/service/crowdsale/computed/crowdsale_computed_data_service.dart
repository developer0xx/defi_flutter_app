import 'package:decimal/decimal.dart';
import 'package:sapiency_app/model/crowdsale/computed/crowdsale_computed_data.dart';
import 'package:sapiency_app/model/crowdsale/input/crowdsale_input.dart';
import 'package:sapiency_app/model/price/precision/price_with_precision.dart';

// business requirement: constant value
const _days = 7;

class CrowdsaleComputedDataService {
  CrowdsaleComputedData compute(CrowdsaleInput input) {
    return CrowdsaleComputedData(
      days: _days,
      endDate: input.startDate?.add(Duration(days: _days)),
      price: input.toRaise != null && input.toSale != null ? computePrice(input.toRaise!, input.toSale!) : null,
    );
  }

  static PriceWithPrecision computePrice(PriceWithPrecision toRaise, PriceWithPrecision toSale) {
    //avoid dividing by 0
    if (toSale.amount == Decimal.zero) return toRaise.copyWith(amount: toRaise.amount / Decimal.one);
    return toRaise.copyWith(amount: toRaise.amount / toSale.amount);
  }
}