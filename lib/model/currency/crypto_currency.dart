import 'package:freezed_annotation/freezed_annotation.dart';

part 'crypto_currency.freezed.dart';

part 'crypto_currency.g.dart';

@freezed
class CryptoCurrency with _$CryptoCurrency {
  factory CryptoCurrency({required String name, required String imageUrl}) = _CryptoCurrency;

  factory CryptoCurrency.fromJson(Map<String, dynamic> json) => _$CryptoCurrencyFromJson(json);
}
