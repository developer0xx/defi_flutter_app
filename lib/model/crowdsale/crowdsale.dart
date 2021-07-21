import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/model/crowdsale/sold/crowdsale_sold.dart';
import 'package:sapiency_app/model/price/precision/price_with_precision.dart';

part 'crowdsale.freezed.dart';

part 'crowdsale.g.dart';

@freezed
class Crowdsale with _$Crowdsale {
  Crowdsale._();

  factory Crowdsale({
    required String title,
    required String description,
    required PriceWithPrecision toRaise,
    required PriceWithPrecision toSale,
    required DateTime startDate,
    required DateTime endDate,
    required int days,
    required PriceWithPrecision price,
    required CrowdsaleSold sold,
    required bool confirmed,
    required String cover,
  }) = _Crowdsale;

  factory Crowdsale.fromJson(Map<String, dynamic> json) => _$CrowdsaleFromJson(json);

  Duration get timeLeft => endDate.difference(DateTime.now());
}
