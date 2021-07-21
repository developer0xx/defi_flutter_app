import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

//TODO add locale
extension DecimalCurrencyFormat on Decimal {
  String toCash(String currency, {int precision = 2}) => toDouble().toCash(currency, precision: precision);

  String toToken(String token, {int precision = 5}) => toDouble().toToken(token, precision: precision);
}

extension DoubleCurrencyFormat on double {
  String toCash(String currency, {int precision = 2}) =>
      NumberFormat.simpleCurrency(name: currency, decimalDigits: precision).format(double.parse("$this"));

  String toToken(String token, {int precision = 4}) =>
      NumberFormat.currency(symbol: '', decimalDigits: precision).format(double.parse('$this')) + ' $token';
}
