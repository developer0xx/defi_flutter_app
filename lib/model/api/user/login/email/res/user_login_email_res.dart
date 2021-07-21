import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_login_email_res.freezed.dart';

part 'user_login_email_res.g.dart';

@Freezed(unionKey: 'result')
class UserLoginEmailRes
    with _$UserLoginEmailRes {
  @FreezedUnionValue('ok')
  factory UserLoginEmailRes.ok({required String token}) = UserLoginEmailResOk;

  @FreezedUnionValue('fail')
  factory UserLoginEmailRes.error() = UserLoginEmailResError;

  factory UserLoginEmailRes.fromJson(Map<String, dynamic> json) => _$UserLoginEmailResFromJson(json);
}
