import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_password_recovery_res.freezed.dart';

part 'user_password_recovery_res.g.dart';

@Freezed(unionKey: 'result')
class UserPasswordRecoveryRes with _$UserPasswordRecoveryRes {
  @FreezedUnionValue('ok')
  factory UserPasswordRecoveryRes.ok() = UserPasswordRecoveryResOk;

  @FreezedUnionValue('fail')
  factory UserPasswordRecoveryRes.error() = UserPasswordRecoveryResError;

  factory UserPasswordRecoveryRes.fromJson(Map<String, dynamic> json) => _$UserPasswordRecoveryResFromJson(json);
}
