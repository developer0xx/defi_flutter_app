import 'package:sapiency_app/common/state/submit/error/submit_state_error.dart';
import 'package:sapiency_app/common/state/submit/use_submit_state.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';
import 'package:sapiency_app/di/injector.dart';
import 'package:sapiency_app/screen/auth/sign_up/state/use_auth_sign_up_flow_state.dart';
import 'package:sapiency_app/service/auth/exception/step/create/auth_step_exception.dart';
import 'package:sapiency_app/service/auth/signup/auth_signup_service.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class AuthSignUpPhoneScreenState {
  final FieldState phoneState;
  final SubmitState submitState;
  final bool isProceedButtonEnabled;

  const AuthSignUpPhoneScreenState({
    required this.phoneState,
    required this.submitState,
    required this.isProceedButtonEnabled,
  });
}

AuthSignUpPhoneScreenState useAuthSignUpPhoneScreenState({required Function() moveToConfirmPhone}) {
  final phoneState = useFieldStateSimple();
  final flowState = useProvided<AuthSignUpFlowState>();
  final signUpService = useInjected<AuthSignupService>();

  performSubmit() async {
    await signUpService.sendVerificationPhone(
      nickname: flowState.nickname!,
      phone: phoneState.value,
    );
  }

  final proceedSubmitState = useSubmitState<void, AuthStepException, Object>(
    performSubmit: performSubmit,
    afterSubmit: (_) async {
      flowState.onPhoneChanged(phoneState.value);
      moveToConfirmPhone();
    },
    mapError: (error) => (error is AuthStepException) ? SubmitStateErrorKnown(error) : SubmitStateErrorUnknown(),
    afterError: (state, error) => state.maybeWhen(
      known: (error) => phoneState.onErrorChanged((context) => context.strings.phoneInput.error.invalid),
      orElse: () {},
    ),
  );

  return AuthSignUpPhoneScreenState(
    phoneState: phoneState,
    submitState: proceedSubmitState,
    isProceedButtonEnabled: phoneState.value.isNotEmpty,
  );
}
