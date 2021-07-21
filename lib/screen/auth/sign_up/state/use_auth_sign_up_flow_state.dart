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

class AuthSignUpFlowState {
  final String? email;
  final String? password;
  final String? nickname;
  final String? phone;
  final Function(String) onEmailChanged;
  final Function(String) onPasswordChanged;
  final Function(String) onNicknameChanged;
  final Function(String) onPhoneChanged;
  final Future<void> Function() onComplete;
  final Function() moveToSignIn;

  const AuthSignUpFlowState({
    required this.email,
    required this.password,
    required this.nickname,
    required this.phone,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.onNicknameChanged,
    required this.onPhoneChanged,
    required this.onComplete,
    required this.moveToSignIn,
  });
}

AuthSignUpFlowState useAuthSignUpFlowState({required Function() moveToHome, required Function() moveToSignIn}) {
  final loginService = useInjected<AuthLoginService>();
  final authState = useProvided<AuthState>();
  final userState = useProvided<UserState>();

  final emailState = useState<String?>(null);
  final passwordState = useState<String?>(null);
  final nicknameState = useState<String?>(null);
  final phoneState = useState<String?>(null);

  performSubmit() async {
    await loginService.loginEmail(
      email: emailState.value!,
      password: passwordState.value!,
    );
  }

  final submitState = useSubmitState<void, Function, AuthLoginException>(
    performSubmit: performSubmit,
    afterSubmit: (_) async {
      authState.changeStatus(AuthStatus.authorized);
      await userState.refresh();
      moveToHome();
    },
    mapError: (error) => SubmitStateErrorUnknown(),
  );

  return AuthSignUpFlowState(
    email: emailState.value,
    password: passwordState.value,
    nickname: nicknameState.value,
    phone: phoneState.value,
    onEmailChanged: (value) => emailState.value = value,
    onPasswordChanged: (value) => passwordState.value = value,
    onNicknameChanged: (value) => nicknameState.value = value,
    onPhoneChanged: (value) => phoneState.value = value,
    onComplete: () async => await submitState.onSubmitPressed(),
    moveToSignIn: moveToSignIn,
  );
}
