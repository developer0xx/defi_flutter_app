import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_step_exception.freezed.dart';

@freezed
class AuthStepException with _$AuthStepException {
  factory AuthStepException() = _AuthStepException;
}
