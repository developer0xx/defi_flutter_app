import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_password_recovery_req.freezed.dart';

part 'user_password_recovery_req.g.dart';

@freezed
class UserPasswordRecoveryReq with _$UserPasswordRecoveryReq {
  factory UserPasswordRecoveryReq({required String email}) = _UserPasswordRecoveryReq;

  factory UserPasswordRecoveryReq.fromJson(Map<String, dynamic> json) => _$UserPasswordRecoveryReqFromJson(json);
}
