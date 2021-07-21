import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_login_exception.freezed.dart';

@freezed
class AuthLoginException with _$AuthLoginException {
  factory AuthLoginException() = _AuthLoginException;
}
