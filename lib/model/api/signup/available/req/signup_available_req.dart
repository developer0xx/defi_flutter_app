import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_available_req.freezed.dart';

part 'signup_available_req.g.dart';

@freezed
class SignupAvailableReq with _$SignupAvailableReq {
  factory SignupAvailableReq.nickname({required String nickname}) = SignupAvailableReqNickname;
  factory SignupAvailableReq.email({required String email}) = SignupAvailableReqEmail;

  factory SignupAvailableReq.fromJson(Map<String, dynamic> json) => _$SignupAvailableReqFromJson(json);
}
