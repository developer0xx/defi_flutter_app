import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/app/state/auth/auth_state.dart';
import 'package:sapiency_app/app/state/user/user_state.dart';
import 'package:sapiency_app/common/state/submit/error/submit_state_error.dart';
import 'package:sapiency_app/common/state/submit/use_submit_state.dart';
import 'package:sapiency_app/common/widgets/input/input_validator.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';
import 'package:sapiency_app/di/injector.dart';
import 'package:sapiency_app/model/auth/auth_status.dart';
import 'package:sapiency_app/service/auth/login/auth_login_service.dart';
import 'package:sapiency_app/service/auth/login/exception/auth_login_exception.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';

class AuthSignInScreenState {
  final FieldState emailState;
  final FieldState passwordState;
  final SubmitState submitState;
  final Function() onSignUpPressed;
  final Function() onForgottenPasswordPressed;
  final String Function(BuildContext)? errorMessage;

  const AuthSignInScreenState({
    required this.emailState,
    required this.passwordState,
    required this.submitState,
    required this.onSignUpPressed,
    required this.onForgottenPasswordPressed,
    required this.errorMessage,
  });
}

AuthSignInScreenState useAuthSignInScreenState({
  required Function() moveToResetPassword,
  required Function() moveToSignUp,
  required Function() moveToHome,
}) {
  final loginService = useInjected<AuthLoginService>();
  final authState = useProvided<AuthState>();
  final userState = useProvided<UserState>();
  final errorMessage = useState<String Function(BuildContext)?>(null);

  final FieldState passwordState = useFieldStateSimple(isObscurable: true);
  final FieldState emailState = useFieldStateSimple();

  bool validate() {
    errorMessage.value = null;
    final emailError = emailState.validate((value) => InputValidator.validateEmailInput(value));
    final passwordError = passwordState.validate((value) => InputValidator.validateRequiredInput(value));
    return emailError == null && passwordError == null;
  }

  performSubmit() async {
    await loginService.loginEmail(
      email: emailState.value,
      password: passwordState.value,
    );
  }

  final proceedSubmitState = useSubmitState<void, AuthLoginException, Object>(
    shouldSubmit: validate,
    performSubmit: performSubmit,
    afterSubmit: (_) async {
      authState.changeStatus(AuthStatus.authorized);
      await userState.refresh();
      moveToHome();
    },
    mapError: (error) {
      if (error is AuthLoginException) return SubmitStateErrorKnown(error);
      else return SubmitStateErrorUnknown();
    },
    afterError: (state, error) => state.maybeWhen(
      known: (error) => errorMessage.value = (context) => context.strings.auth.signIn.loginError,
      orElse: () {},
    ),
  );

  return AuthSignInScreenState(
    emailState: emailState,
    passwordState: passwordState,
    submitState: proceedSubmitState,
    onSignUpPressed: moveToSignUp,
    onForgottenPasswordPressed: moveToResetPassword,
    errorMessage: errorMessage.value,
  );
}
