import 'package:freezed_annotation/freezed_annotation.dart';


part 'user_signup_res.freezed.dart';

part 'user_signup_res.g.dart';

@Freezed(unionKey: 'result')
class UserSignupRes with _$UserSignupRes {
  @FreezedUnionValue('ok')
  factory UserSignupRes.ok({required String nickname}) = UserSignupResOk;

  @FreezedUnionValue('fail')
  factory UserSignupRes.error() = UserSignupResError;

  factory UserSignupRes.fromJson(Map<String, dynamic> json) => _$UserSignupResFromJson(json);
}
