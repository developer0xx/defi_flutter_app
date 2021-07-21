import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/model/price/precision/price_with_precision.dart';
import 'package:sapiency_app/model/user/wallet/user_wallet.dart';

part 'user_wallets.freezed.dart';

part 'user_wallets.g.dart';

@freezed
class UserWallets with _$UserWallets {
  factory UserWallets({
    required PriceWithPrecision estimate,
    required String address,
    required Map<String, UserWallet> items,
  }) = _UserWallets;

  factory UserWallets.fromJson(Map<String, dynamic> json) => _$UserWalletsFromJson(json);
}
