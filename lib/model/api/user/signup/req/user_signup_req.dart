import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_signup_req.freezed.dart';

part 'user_signup_req.g.dart';

@freezed
class UserSignupReq with _$UserSignupReq {
  factory UserSignupReq({
    required String nickname,
    required String password,
    required List<String> consents,
    required String language,
  }) = _UserSignupReq;

  factory UserSignupReq.fromJson(Map<String, dynamic> json) => _$UserSignupReqFromJson(json);
}
