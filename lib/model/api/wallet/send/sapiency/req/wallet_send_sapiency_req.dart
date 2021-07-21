import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_send_sapiency_req.freezed.dart';

part 'wallet_send_sapiency_req.g.dart';

@freezed
class WalletSendSapiencyReq with _$WalletSendSapiencyReq {
  factory WalletSendSapiencyReq({
    required double amount,
    required String currency,
    required String to,
  }) = _WalletSendSapiencyReq;

  factory WalletSendSapiencyReq.fromJson(Map<String, dynamic> json) => _$WalletSendSapiencyReqFromJson(json);
}
