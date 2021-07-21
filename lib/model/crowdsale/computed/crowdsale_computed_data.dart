import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/model/price/precision/price_with_precision.dart';

part 'crowdsale_computed_data.freezed.dart';

@freezed
class CrowdsaleComputedData with _$CrowdsaleComputedData {
  factory CrowdsaleComputedData({
    required int days,
    DateTime? endDate,
    PriceWithPrecision? price,
  }) = _CrowdsaleComputedData;
}
