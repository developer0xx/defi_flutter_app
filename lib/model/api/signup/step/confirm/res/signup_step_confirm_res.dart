import 'package:freezed_annotation/freezed_annotation.dart';


part 'signup_step_confirm_res.freezed.dart';

part 'signup_step_confirm_res.g.dart';

@Freezed(unionKey: 'result')
class SignupStepConfirmRes
    with _$SignupStepConfirmRes {
  @FreezedUnionValue('ok')
  factory SignupStepConfirmRes.ok() = SignupStepConfirmResOk;

  @FreezedUnionValue('fail')
  factory SignupStepConfirmRes.error() = SignupStepConfirmResError;

  factory SignupStepConfirmRes.fromJson(Map<String, dynamic> json) => _$SignupStepConfirmResFromJson(json);
}
