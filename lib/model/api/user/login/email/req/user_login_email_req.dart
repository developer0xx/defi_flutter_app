import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/model/api/user/login/type/user_login_type.dart';

part 'user_login_email_req.freezed.dart';

part 'user_login_email_req.g.dart';

@freezed
class UserLoginEmailReq with _$UserLoginEmailReq {
  factory UserLoginEmailReq({
    @Default(UserLoginType.email) UserLoginType type,
    required String email,
    required String password,
  }) = _UserLoginEmailReq;

  factory UserLoginEmailReq.fromJson(Map<String, dynamic> json) => _$UserLoginEmailReqFromJson(json);
}
