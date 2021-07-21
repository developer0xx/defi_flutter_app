import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/model/price/precision/price_with_precision.dart';

part 'crowdsale_input.freezed.dart';

part 'crowdsale_input.g.dart';

@freezed
class CrowdsaleInput with _$CrowdsaleInput {
  factory CrowdsaleInput({
    PriceWithPrecision? toRaise,
    PriceWithPrecision? toSale,
    DateTime? startDate,
    String? title,
    String? description,
    String? coverUrl,
    @Default(7) int days, // TODO remove from API
  }) = _CrowdsaleInput;

  factory CrowdsaleInput.fromJson(Map<String, dynamic> json) => _$CrowdsaleInputFromJson(json);
}
