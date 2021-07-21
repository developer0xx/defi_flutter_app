import 'package:freezed_annotation/freezed_annotation.dart';


part 'signup_available_res.freezed.dart';

part 'signup_available_res.g.dart';

@Freezed(unionKey: 'result')
class SignupAvailableRes
    with _$SignupAvailableRes {
  @FreezedUnionValue('ok')
  factory SignupAvailableRes.ok() = SignupAvailableResOk;

  @FreezedUnionValue('fail')
  factory SignupAvailableRes.error() = SignupAvailableResError;

  factory SignupAvailableRes.fromJson(Map<String, dynamic> json) => _$SignupAvailableResFromJson(json);
}
