import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/util/converter/decimal_converter.dart';
import 'package:sapiency_app/util/extension/decimal_extension.dart';

part 'price_with_precision.freezed.dart';

part 'price_with_precision.g.dart';

@freezed
class PriceWithPrecision with _$PriceWithPrecision {
  PriceWithPrecision._();

  factory PriceWithPrecision({
    required String symbol,
    @DecimalConverter() required Decimal amount,
    required int precision,
  }) = _PriceWithPrecision;

  factory PriceWithPrecision.fromJson(Map<String, dynamic> json) => _$PriceWithPrecisionFromJson(json);

  static PriceWithPrecision usd(Decimal amount) => PriceWithPrecision(symbol: 'USD', amount: amount, precision: 2);

  static PriceWithPrecision token(String symbol, Decimal amount) =>
      PriceWithPrecision(symbol: symbol, amount: amount, precision: 4);

  String toCashDisplay() => amount.toCash(symbol, precision: precision);

  String toTokenDisplay() => amount.toToken(symbol, precision: precision);

  String toValueDisplay() => amount.toStringAsFixed(precision);
}
