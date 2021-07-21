import 'package:sapiency_app/common/state/submit/error/submit_state_error.dart';
import 'package:sapiency_app/common/state/submit/use_submit_state.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';
import 'package:sapiency_app/di/injector.dart';
import 'package:sapiency_app/screen/auth/sign_up/state/use_auth_sign_up_flow_state.dart';
import 'package:sapiency_app/service/auth/exception/step/create/auth_step_exception.dart';
import 'package:sapiency_app/service/auth/signup/auth_signup_service.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class AuthSignUpConfirmEmailScreenState {
  final FieldState pinState;
  final SubmitState confirmSubmitState;
  final bool isConfirmButtonEnabled;
  final SubmitState resendSubmitState;
  final Stream<Object> pinErrorStream;

  const AuthSignUpConfirmEmailScreenState({
    required this.pinState,
    required this.confirmSubmitState,
    required this.isConfirmButtonEnabled,
    required this.resendSubmitState,
    required this.pinErrorStream,
  });
}

AuthSignUpConfirmEmailScreenState useAuthSignUpConfirmEmailScreenState() {
  final flowState = useProvided<AuthSignUpFlowState>();
  final signUpService = useInjected<AuthSignupService>();

  final pinState = useFieldStateSimple();

  performSubmit() async {
    await signUpService.confirmVerificationEmail(
      nickname: flowState.nickname!,
      email: flowState.email!,
      pin: pinState.value,
    );
  }

  final confirmSubmitState = useSubmitState<void, AuthStepException, Object>(
    performSubmit: performSubmit,
    afterSubmit: (_) async => await flowState.onComplete(),
    mapError: (error) {
      if (error is AuthStepException) return SubmitStateErrorKnown(error);
      else return SubmitStateErrorUnknown();
    },
    afterError: (state, error) => state.maybeWhen(
      known: (error) => pinState.onErrorChanged((context) => context.strings.pinInput.error.invalid),
      orElse: () {},
    ),
  );

  final resendSubmitState = useSubmitStateSimple(
    performSubmit: () async => await signUpService.sendVerificationEmail(
      nickname: flowState.nickname!,
      email: flowState.email!,
    ),
  );

  return AuthSignUpConfirmEmailScreenState(
    pinState: pinState,
    confirmSubmitState: confirmSubmitState,
    isConfirmButtonEnabled: pinState.value.length == 4,
    resendSubmitState: resendSubmitState,
    pinErrorStream: confirmSubmitState.errorStream,
  );
}
