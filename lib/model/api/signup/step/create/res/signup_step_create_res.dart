import 'package:freezed_annotation/freezed_annotation.dart';


part 'signup_step_create_res.freezed.dart';

part 'signup_step_create_res.g.dart';

@Freezed(unionKey: 'result')
class SignupStepCreateRes
    with _$SignupStepCreateRes {
  @FreezedUnionValue('ok')
  factory SignupStepCreateRes.ok() = SignupStepCreateResOk;

  @FreezedUnionValue('fail')
  factory SignupStepCreateRes.error() = SignupStepCreateResError;

  factory SignupStepCreateRes.fromJson(Map<String, dynamic> json) => _$SignupStepCreateResFromJson(json);
}
