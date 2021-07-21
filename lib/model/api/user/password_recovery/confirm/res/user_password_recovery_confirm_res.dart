import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_password_recovery_confirm_res.freezed.dart';

part 'user_password_recovery_confirm_res.g.dart';

@Freezed(unionKey: 'result')
class UserPasswordRecoveryConfirmRes with _$UserPasswordRecoveryConfirmRes {
  @FreezedUnionValue('ok')
  factory UserPasswordRecoveryConfirmRes.ok() = UserPasswordRecoveryConfirmResOk;

  @FreezedUnionValue('fail')
  factory UserPasswordRecoveryConfirmRes.error() = UserPasswordRecoveryConfirmResError;

  factory UserPasswordRecoveryConfirmRes.fromJson(Map<String, dynamic> json) =>
      _$UserPasswordRecoveryConfirmResFromJson(json);
}
