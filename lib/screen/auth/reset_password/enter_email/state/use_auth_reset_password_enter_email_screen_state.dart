import 'package:sapiency_app/common/state/submit/error/submit_state_error.dart';
import 'package:sapiency_app/common/state/submit/use_submit_state.dart';
import 'package:sapiency_app/common/widgets/input/input_validator.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';
import 'package:sapiency_app/di/injector.dart';
import 'package:sapiency_app/screen/auth/reset_password/state/use_auth_reset_password_flow_state.dart';
import 'package:sapiency_app/service/auth/exception/password_recovery/auth_password_recovery_exception.dart';
import 'package:sapiency_app/service/auth/password_recovery/auth_password_recovery_service.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';

class AuthResetPasswordEnterEmailScreenState {
  final FieldState emailState;
  final SubmitState submitState;
  final bool isSubmitButtonEnabled;

  const AuthResetPasswordEnterEmailScreenState({
    required this.emailState,
    required this.submitState,
    required this.isSubmitButtonEnabled,
  });
}

AuthResetPasswordEnterEmailScreenState useAuthResetPasswordEnterEmailScreenState(
    {required Function() moveToSetNewPassword}) {
  final flowState = useProvided<AuthResetPasswordFlowState>();
  final passwordRecoveryService = useInjected<AuthPasswordRecoveryService>();
  final FieldState emailState = useFieldStateSimple();

  bool validate() {
    final emailError = emailState.validate((value) => InputValidator.validateEmailInput(value));
    return emailError == null;
  }

  final submitState = useSubmitState<void, AuthPasswordRecoveryException, Object>(
    shouldSubmit: validate,
    performSubmit: () async => await passwordRecoveryService.initPasswordRecovery(emailState.value),
    afterSubmit: (_) async {
      flowState.onEmailChanged(emailState.value);
      moveToSetNewPassword();
    },
    mapError: (error) {
      if (error is AuthPasswordRecoveryException) return SubmitStateErrorKnown(error);
      else return SubmitStateErrorUnknown();
    },
    afterError: (state, error) => state.maybeWhen(
      known: (error) => emailState.onErrorChanged((context) => context.strings.emailInput.error.notExist),
      orElse: () {},
    ),
  );

  return AuthResetPasswordEnterEmailScreenState(
    emailState: emailState,
    submitState: submitState,
    isSubmitButtonEnabled: emailState.value.isNotEmpty,
  );
}
