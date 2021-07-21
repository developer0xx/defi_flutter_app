import 'package:sapiency_app/common/state/submit/error/submit_state_error.dart';
import 'package:sapiency_app/common/state/submit/use_submit_state.dart';
import 'package:sapiency_app/common/widgets/input/input_validator.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';
import 'package:sapiency_app/di/injector.dart';
import 'package:sapiency_app/screen/auth/reset_password/state/use_auth_reset_password_flow_state.dart';
import 'package:sapiency_app/service/auth/exception/password_recovery/confirm/auth_password_recovery_confirm_exception.dart';
import 'package:sapiency_app/service/auth/password_recovery/auth_password_recovery_service.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class AuthResetPasswordSetNewScreenState {
  final FieldState passwordState;
  final FieldState confirmPasswordState;
  final SubmitState submitState;
  final bool isSubmitButtonEnabled;
  final FieldState pinState;
  final Stream<Object> pinErrorStream;

  const AuthResetPasswordSetNewScreenState({
    required this.passwordState,
    required this.confirmPasswordState,
    required this.submitState,
    required this.isSubmitButtonEnabled,
    required this.pinState,
    required this.pinErrorStream,
  });
}

AuthResetPasswordSetNewScreenState useAuthResetPasswordSetNewScreenState() {
  final flowState = useProvided<AuthResetPasswordFlowState>();
  final passwordRecoveryService = useInjected<AuthPasswordRecoveryService>();
  final FieldState confirmPasswordState = useFieldStateSimple(isObscurable: true);
  final FieldState passwordState = useFieldStateSimple(isObscurable: true);
  final pinState = useFieldStateSimple();

  bool _validate() {
    final passwordError = passwordState.validate((value) => InputValidator.validatePassword(value));
    final confirmPasswordError =
        confirmPasswordState.validate((value) => InputValidator.validateConfirmPassword(passwordState.value, value));
    return passwordError == null && confirmPasswordError == null;
  }

  performSubmit() async {
    await passwordRecoveryService.confirmPasswordRecovery(
      email: flowState.email!,
      code: pinState.value,
      newPassword: passwordState.value,
    );
  }

  final submitState = useSubmitState<void, AuthPasswordRecoveryConfirmException, Object>(
    shouldSubmit: _validate,
    performSubmit: performSubmit,
    afterSubmit: (_) async {
      flowState.onPasswordChanged(passwordState.value);
      await flowState.onComplete();
    },
    mapError: (error) {
      if (error is AuthPasswordRecoveryConfirmException) return SubmitStateErrorKnown(error);
      else return SubmitStateErrorUnknown();
    },
    afterError: (state, error) => state.maybeWhen(
      known: (error) => pinState.onErrorChanged((context) => context.strings.pinInput.error.invalid),
      orElse: () {},
    ),
  );

  return AuthResetPasswordSetNewScreenState(
    passwordState: passwordState,
    confirmPasswordState: confirmPasswordState,
    submitState: submitState,
    isSubmitButtonEnabled:
        passwordState.value.isNotEmpty && confirmPasswordState.value.isNotEmpty && pinState.value.length == 4,
    pinState: pinState,
    pinErrorStream: submitState.errorStream,
  );
}
