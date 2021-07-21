import 'package:decimal/decimal.dart';

extension StringExtensions on String {
  String? nullIfEmpty() => isEmpty ? null : this;

  bool doesParseToDecimal() {
    try {
      Decimal.parse(this);
      return true;
    } catch (_) {
      return false;
    }
  }
}
