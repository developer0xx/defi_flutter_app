import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/model/currency/crypto_currency.dart';
import 'package:sapiency_app/model/price/precision/price_with_precision.dart';
import 'package:sapiency_app/model/user/public/public_user.dart';

part 'user_wallet.freezed.dart';

part 'user_wallet.g.dart';

@Freezed(unionKey: 'type')
class UserWallet with _$UserWallet {
  const UserWallet._();

  @FreezedUnionValue('user')
  factory UserWallet.user({
    required PriceWithPrecision value,
    required PriceWithPrecision estimate,
    required String address,
    required PublicUserInfluencer user,
  }) = UserWalletUser;

  @FreezedUnionValue('crypto')
  factory UserWallet.crypto({
    required PriceWithPrecision value,
    required PriceWithPrecision estimate,
    required String address,
    required CryptoCurrency? cryptoCurrency, // TODO: remove nullability when API is fixed
  }) = UserWalletCrypto;

  factory UserWallet.fromJson(Map<String, dynamic> json) => _$UserWalletFromJson(json);

  PublicUserInfluencer? get userOrNull => map(user: (it) => it.user, crypto: (_) => null);
  CryptoCurrency? get cryptoCurrencyOrNull => map(user: (_) => null, crypto: (it) => it.cryptoCurrency);
}
