import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_step_create_req.freezed.dart';

part 'signup_step_create_req.g.dart';

@freezed
class SignupStepCreateReq with _$SignupStepCreateReq {
  factory SignupStepCreateReq.email({
    required String nickname,
    required String email,
  }) = _SignupStepCreateReqEmail;

  factory SignupStepCreateReq.phone({
    required String nickname,
    required String phone,
  }) = _SignupStepCreateReqPhone;

  factory SignupStepCreateReq.fromJson(Map<String, dynamic> json) => _$SignupStepCreateReqFromJson(json);
}
