import 'package:sapiency_app/common/state/submit/error/submit_state_error.dart';
import 'package:sapiency_app/common/state/submit/use_submit_state.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';
import 'package:sapiency_app/di/injector.dart';
import 'package:sapiency_app/screen/auth/sign_up/state/use_auth_sign_up_flow_state.dart';
import 'package:sapiency_app/service/auth/exception/step/create/auth_step_exception.dart';
import 'package:sapiency_app/service/auth/signup/auth_signup_service.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class AuthSignUpConfirmPhoneScreenState {
  final FieldState pinState;
  final String phoneNumber;
  final SubmitState confirmSubmitState;
  final bool isConfirmButtonEnabled;
  final SubmitState resendSubmitState;
  final Stream<Object> pinErrorStream;

  const AuthSignUpConfirmPhoneScreenState({
    required this.pinState,
    required this.phoneNumber,
    required this.confirmSubmitState,
    required this.isConfirmButtonEnabled,
    required this.resendSubmitState,
    required this.pinErrorStream,
  });
}

AuthSignUpConfirmPhoneScreenState useAuthSignUpConfirmPhoneScreenState() {
  final flowState = useProvided<AuthSignUpFlowState>();
  final signUpService = useInjected<AuthSignupService>();

  final pinState = useFieldStateSimple();

  performSubmit() async {
    await signUpService.confirmVerificationPhone(
      nickname: flowState.nickname!,
      phone: flowState.phone!,
      pin: pinState.value,
    );
  }

  final confirmSubmitState = useSubmitState<void, AuthStepException, Object>(
    performSubmit: performSubmit,
    afterSubmit: (_)  async => await flowState.onComplete(),
    mapError: (error) => (error is AuthStepException) ? SubmitStateErrorKnown(error) : SubmitStateErrorUnknown(),
    afterError: (state, error) => state.maybeWhen(
      known: (error) => pinState.onErrorChanged((context) => context.strings.pinInput.error.invalid),
      orElse: () {},
    ),
  );

  final resendState = useSubmitStateSimple(
    performSubmit: () async => await signUpService.sendVerificationPhone(
      nickname: flowState.nickname!,
      phone: flowState.phone!,
    ),
  );

  String _obscureNumber(number) => number.replaceAll(RegExp(r"\d(?=\d{3})"), "-");

  return AuthSignUpConfirmPhoneScreenState(
    pinState: pinState,
    phoneNumber: _obscureNumber(flowState.phone),
    confirmSubmitState: confirmSubmitState,
    isConfirmButtonEnabled: pinState.value.length == 4,
    resendSubmitState: resendState,
    pinErrorStream: confirmSubmitState.errorStream,
  );
}
