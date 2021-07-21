import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/model/price/precision/price_with_precision.dart';
import 'package:sapiency_app/util/converter/decimal_converter.dart';

part 'crowdsale_sold.freezed.dart';

part 'crowdsale_sold.g.dart';

@freezed
class CrowdsaleSold with _$CrowdsaleSold {
  factory CrowdsaleSold({
    required double percent,
    required PriceWithPrecision value,
    required int investors,
  }) = _CrowdsaleSold;

  factory CrowdsaleSold.fromJson(Map<String, dynamic> json) => _$CrowdsaleSoldFromJson(json);
}
