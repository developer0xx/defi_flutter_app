import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:sapiency_app/model/api/wallet/send/sapiency/req/wallet_send_sapiency_req.dart';
import 'package:sapiency_app/model/api/wallet/send/sapiency/res/wallet_send_sapiency_res.dart';
import 'package:sapiency_app/service/api/api_service.dart';
import 'package:sapiency_app/service/wallet/exception/send/wallet_send_exception.dart';
import 'dart:convert';

class WalletService {
  final ApiService _apiService;
  static const String _encodedNicknamePrefix = '&';

  const WalletService(this._apiService);

  String _getSendValue(value) {
    if (value[0] == _encodedNicknamePrefix)
      return decodeNickname(value);
    else
      return value;
  }

  Future<void> send({
    required String token,
    required Decimal amount,
    required String nicknameOrEmailOrAddress,
  }) async {
    final value = _getSendValue(nicknameOrEmailOrAddress);

    final req = WalletSendSapiencyReq(amount: amount.toDouble(), currency: token, to: value);
    final response = await _apiService.walletSendSapiency(req);
    if (response.body! is WalletSendSapiencyResError) throw WalletSendException();
  }

  static String encodeNickname(String nick) {
    final encodedText = utf8.encode(nick);
    final base64Str = base64.encode(encodedText);
    return _encodedNicknamePrefix + base64Str;
  }

  static String decodeNickname(String base64Nick) {
    final str = base64Nick.split(_encodedNicknamePrefix)[1];
    final decodedText = base64.decode(str);
    final nick = utf8.decode(decodedText);
    return nick;
  }
}
