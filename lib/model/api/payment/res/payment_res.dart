import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_res.freezed.dart';

part 'payment_res.g.dart';

@Freezed(unionKey: 'result')
class PaymentRes with _$PaymentRes {
  @FreezedUnionValue('ok')
  factory PaymentRes.ok({required String url}) = PaymentResOk;

  @FreezedUnionValue('fail')
  factory PaymentRes.error() = PaymentResError;

  factory PaymentRes.fromJson(Map<String, dynamic> json) => _$PaymentResFromJson(json);
}
