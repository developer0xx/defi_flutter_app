import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_step_confirm_req.freezed.dart';

part 'signup_step_confirm_req.g.dart';

@freezed
class SignupStepConfirmReq with _$SignupStepConfirmReq {
  factory SignupStepConfirmReq.email({
    required String nickname,
    required String email,
    required String pin,
  }) = SignupStepConfirmReqEmail;

  factory SignupStepConfirmReq.phone({
    required String nickname,
    required String phone,
    required String pin,
  }) = SignupStepConfirmReqPhone;

  factory SignupStepConfirmReq.fromJson(Map<String, dynamic> json) => _$SignupStepConfirmReqFromJson(json);
}
