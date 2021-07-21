import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_password_recovery_confirm_req.freezed.dart';

part 'user_password_recovery_confirm_req.g.dart';

@freezed
class UserPasswordRecoveryConfirmReq with _$UserPasswordRecoveryConfirmReq {
  factory UserPasswordRecoveryConfirmReq({
    required String email,
    required String code,
    required String password,
  }) = _UserPasswordRecoveryConfirmReq;

  factory UserPasswordRecoveryConfirmReq.fromJson(Map<String, dynamic> json) =>
      _$UserPasswordRecoveryConfirmReqFromJson(json);
}
