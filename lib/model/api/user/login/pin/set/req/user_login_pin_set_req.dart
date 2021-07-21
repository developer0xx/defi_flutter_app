import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/model/api/user/login/type/user_login_type.dart';

part 'user_login_pin_set_req.freezed.dart';

part 'user_login_pin_set_req.g.dart';

@freezed
class UserLoginPinSetReq with _$UserLoginPinSetReq {
  factory UserLoginPinSetReq({
    @Default(UserLoginType.devicePin) UserLoginType type,
    required String email,
    required String password,
    required String deviceId,
    required String pin,
  }) = _UserLoginPinSetReq;

  factory UserLoginPinSetReq.fromJson(Map<String, dynamic> json) => _$UserLoginPinSetReqFromJson(json);
}
