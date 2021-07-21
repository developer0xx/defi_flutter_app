import 'package:freezed_annotation/freezed_annotation.dart';


part 'user_login_pin_set_res.freezed.dart';

part 'user_login_pin_set_res.g.dart';

@Freezed(unionKey: 'result')
class UserLoginPinSetRes
    with _$UserLoginPinSetRes {
  @FreezedUnionValue('ok')
  factory UserLoginPinSetRes.ok() = UserLoginPinSetResOk;

  @FreezedUnionValue('fail')
  factory UserLoginPinSetRes.error() = UserLoginPinSetResError;

  factory UserLoginPinSetRes.fromJson(Map<String, dynamic> json) => _$UserLoginPinSetResFromJson(json);
}
