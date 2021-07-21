import 'package:freezed_annotation/freezed_annotation.dart';


part 'user_login_pin_res.freezed.dart';

part 'user_login_pin_res.g.dart';

@Freezed(unionKey: 'result')
class UserLoginPinRes
    with _$UserLoginPinRes {
  @FreezedUnionValue('ok')
  factory UserLoginPinRes.ok({required String token}) = UserLoginPinResOk;

  @FreezedUnionValue('fail')
  factory UserLoginPinRes.error() = UserLoginPinResError;

  factory UserLoginPinRes.fromJson(Map<String, dynamic> json) => _$UserLoginPinResFromJson(json);
}
