import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_start_sign_up_exception.freezed.dart';

part 'auth_start_sign_up_exception.g.dart';

@freezed
class AuthStartSignUpException with _$AuthStartSignUpException {
  factory AuthStartSignUpException.emailExists() = AuthStartSignUpExceptionEmailExists;

  factory AuthStartSignUpException.nicknameExists() = AuthStartSignUpExceptionNicknameExists;

  factory AuthStartSignUpException.unknown() = AuthStartSignUpExceptionUnknown;

  factory AuthStartSignUpException.fromJson(Map<String, dynamic> json) => _$AuthStartSignUpExceptionFromJson(json);
}
