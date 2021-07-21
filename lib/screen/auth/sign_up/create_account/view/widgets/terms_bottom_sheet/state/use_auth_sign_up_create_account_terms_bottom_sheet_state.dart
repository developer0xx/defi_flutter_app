import 'package:sapiency_app/util/hook/use_togglable_bool.dart';

class AuthSignUpCreateAccountTermsBottomSheetState {
  final Function() onServiceTermsPressed;
  final Function() onPrivacyPolicyPressed;
  final Function() onAcceptPressed;
  final bool isAcceptButtonEnabled;
  final TogglableBoolState marketingConcernsSwitcherState;

  const AuthSignUpCreateAccountTermsBottomSheetState({
    required this.onServiceTermsPressed,
    required this.onPrivacyPolicyPressed,
    required this.onAcceptPressed,
    required this.isAcceptButtonEnabled,
    required this.marketingConcernsSwitcherState,
  });
}

AuthSignUpCreateAccountTermsBottomSheetState useAuthSignUpCreateAccountScreenTermsBottomSheetState({
  required Function(List<String> consents) close,
}) {
  final marketingConcernsSwitcherState = useTogglableBool(false);

  return AuthSignUpCreateAccountTermsBottomSheetState(
    onServiceTermsPressed: () {/* show service terms */},
    onPrivacyPolicyPressed: () {/* show privacy policy */},
    marketingConcernsSwitcherState: marketingConcernsSwitcherState,
    isAcceptButtonEnabled: marketingConcernsSwitcherState.value,
    onAcceptPressed: () => close([if(marketingConcernsSwitcherState.value) "marketing"]),
  );
}
