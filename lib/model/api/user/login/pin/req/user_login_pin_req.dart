import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/model/api/user/login/type/user_login_type.dart';

part 'user_login_pin_req.freezed.dart';

part 'user_login_pin_req.g.dart';

@freezed
class UserLoginPinReq with _$UserLoginPinReq {
  factory UserLoginPinReq({
    @Default(UserLoginType.devicePin) UserLoginType type,
    required String email,
    required String deviceId,
    required String pin,
  }) = _UserLoginPinReq;

  factory UserLoginPinReq.fromJson(Map<String, dynamic> json) => _$UserLoginPinReqFromJson(json);
}
