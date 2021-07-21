import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/app/state/auth/auth_state.dart';
import 'package:sapiency_app/app/state/user/user_state.dart';
import 'package:sapiency_app/common/state/submit/error/submit_state_error.dart';
import 'package:sapiency_app/common/state/submit/use_submit_state.dart';
import 'package:sapiency_app/di/injector.dart';
import 'package:sapiency_app/model/auth/auth_status.dart';
import 'package:sapiency_app/service/auth/login/auth_login_service.dart';
import 'package:sapiency_app/service/auth/login/exception/auth_login_exception.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';

class AuthResetPasswordFlowState {
  final String? email;
  final String? password;
  final Function(String) onEmailChanged;
  final Function(String) onPasswordChanged;
  final Future<void> Function() onComplete;
  const AuthResetPasswordFlowState({
    required this.email,
    required this.password,
    required this.onComplete,
    required this.onEmailChanged,
    required this.onPasswordChanged,
});
}

AuthResetPasswordFlowState useAuthResetPasswordFlowState({required Function() moveToHome}) {
  final loginService = useInjected<AuthLoginService>();
  final authState = useProvided<AuthState>();
  final userState = useProvided<UserState>();

  final emailState = useState<String?>(null);
  final passwordState = useState<String?>(null);

  _performSubmit() async {
    await loginService.loginEmail(
      email: emailState.value!,
      password: passwordState.value!,
    );
  }

  final submitState = useSubmitState<void, Function, AuthLoginException>(
    performSubmit: _performSubmit,
    afterSubmit: (_) async {
      authState.changeStatus(AuthStatus.authorized);
      await userState.refresh();
      moveToHome();
    },
    mapError: (error) => SubmitStateErrorUnknown(),
  );

  return AuthResetPasswordFlowState(
    email: emailState.value,
    password: passwordState.value,
    onEmailChanged: (value) => emailState.value = value,
    onPasswordChanged: (value) => passwordState.value = value,
    onComplete: () async => await submitState.onSubmitPressed(),
  );
}