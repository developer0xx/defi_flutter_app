import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/common/state/submit/error/submit_state_error.dart';
import 'package:sapiency_app/common/state/submit/use_submit_state.dart';
import 'package:sapiency_app/common/widgets/input/input_validator.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';
import 'package:sapiency_app/di/injector.dart';
import 'package:sapiency_app/screen/auth/sign_up/state/use_auth_sign_up_flow_state.dart';
import 'package:sapiency_app/service/auth/exception/signup/auth_start_sign_up_exception.dart';
import 'package:sapiency_app/service/auth/signup/auth_signup_service.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class AuthSignUpCreateAccountScreenState {
  final FieldState emailState;
  final FieldState nicknameState;
  final FieldState passwordState;
  final SubmitState submitState;
  final Function() onSignInPressed;
  final Function(BuildContext) showTermsBottomSheet;

  const AuthSignUpCreateAccountScreenState({
    required this.emailState,
    required this.nicknameState,
    required this.passwordState,
    required this.submitState,
    required this.onSignInPressed,
    required this.showTermsBottomSheet,
  });
}

AuthSignUpCreateAccountScreenState useAuthSignUpCreateAccountScreenState({
  required Function() moveToConfirmEmail,
  required Function(BuildContext, Function(List<String>) onClosed) showTermsBottomSheet,
}) {
  final flowState = useProvided<AuthSignUpFlowState>();
  final signUpService = useInjected<AuthSignupService>();
  final consentsState = useState<List<String>>([]);
  final FieldState passwordState = useFieldStateSimple(isObscurable: true);
  final FieldState nicknameState = useFieldStateSimple();
  final FieldState emailState = useFieldStateSimple();

  bool validate() {
    final emailError = emailState.validate((value) => InputValidator.validateEmailInput(value));
    final nicknameError = nicknameState.validate((value) => InputValidator.validateRequiredInput(value));
    final passwordError = passwordState.validate((value) => InputValidator.validatePassword(value));
    return emailError == null && nicknameError == null && passwordError == null;
  }

  performSubmit() async {
    await signUpService.startSignUp(
      email: emailState.value,
      nickname: nicknameState.value,
      password: passwordState.value,
    );

    await signUpService.sendVerificationEmail(
      email: emailState.value,
      nickname: nicknameState.value,
    );
  }

  final submitState = useSubmitState<void, AuthStartSignUpException, Object>(
    shouldSubmit: validate,
    performSubmit: performSubmit,
    afterSubmit: (_) async {
      flowState.onEmailChanged(emailState.value);
      flowState.onPasswordChanged(passwordState.value);
      flowState.onNicknameChanged(nicknameState.value);
      moveToConfirmEmail();
    },
    mapError: (error) => (error is AuthStartSignUpException) ? SubmitStateErrorKnown(error) : SubmitStateErrorUnknown(),
    afterError: (state, _) => state.maybeWhen(
      known: (error) => error.maybeWhen(
        emailExists: () => emailState.onErrorChanged((context) => context.strings.emailInput.error.alreadyExist),
        nicknameExists: () => nicknameState.onErrorChanged((context) => context.strings.nicknameInput.error.alreadyExist),
        orElse: () {},
      ),
      orElse: () {},
    ),
  );

  return AuthSignUpCreateAccountScreenState(
    emailState: emailState,
    nicknameState: nicknameState,
    passwordState: passwordState,
    submitState: submitState,
    onSignInPressed: flowState.moveToSignIn,
    showTermsBottomSheet: (context) => showTermsBottomSheet(
      context,
      (consents) {
        consentsState.value = consents;
        submitState.onSubmitPressed();
      },
    ),
  );
}
