import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/model/api/payment/provider/payment_provider.dart';
import 'package:sapiency_app/model/api/payment/type/payment_type.dart';
import 'package:sapiency_app/util/converter/decimal_converter.dart';

part 'payment_req.freezed.dart';

part 'payment_req.g.dart';

@freezed
class PaymentReq with _$PaymentReq {
  factory PaymentReq({
    required PaymentProvider provider,
    required PaymentType type,
    required String token,
    @DecimalConverter() required Decimal quantity,
    required String currency,
    required String description,
  }) = _PaymentReq;

  factory PaymentReq.fromJson(Map<String, dynamic> json) => _$PaymentReqFromJson(json);
}
