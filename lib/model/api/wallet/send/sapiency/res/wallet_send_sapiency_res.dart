import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_send_sapiency_res.freezed.dart';

part 'wallet_send_sapiency_res.g.dart';

@Freezed(unionKey: 'result')
class WalletSendSapiencyRes with _$WalletSendSapiencyRes {
  @FreezedUnionValue('ok')
  factory WalletSendSapiencyRes.ok() = WalletSendSapiencyResOk;

  @FreezedUnionValue('fail')
  factory WalletSendSapiencyRes.error() = WalletSendSapiencyResError;

  factory WalletSendSapiencyRes.fromJson(Map<String, dynamic> json) => _$WalletSendSapiencyResFromJson(json);
}
