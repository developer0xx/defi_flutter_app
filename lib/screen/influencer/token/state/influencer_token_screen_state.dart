import 'package:sapiency_app/common/widgets/input/input_validator.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';
import 'package:sapiency_app/screen/influencer/flow/influencer_flow_state.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';

class InfluencerTokenScreenState {
  final FieldState symbolFieldState;
  final FieldState tokenFieldState;
  final Function() onProceed;

  const InfluencerTokenScreenState({
    required this.onProceed,
    required this.symbolFieldState,
    required this.tokenFieldState,
  });
}

InfluencerTokenScreenState useInfluencerTokenScreenState({required Function() navigateToCrowdsale}) {
  final flowState = useProvided<InfluencerFlowState>();
  final influencer = flowState.influencer;

  final tokenFieldState = useFieldStateSimple(initialValue: influencer.token);
  final tokenNameFieldState = useFieldStateSimple(initialValue: influencer.tokenName);

  bool validate() {
    final tokenError = tokenFieldState.validate((value) => InputValidator.validateRequiredInput(value));
    final nameError = tokenNameFieldState.validate((value) => InputValidator.validateRequiredInput(value));

    return tokenError == null && nameError == null;
  }

  onProceed() {
    if (validate()) {
      navigateToCrowdsale();
      flowState.onInfluencerUpdated(
        influencer.copyWith(
          token: tokenFieldState.value.toUpperCase(),
          tokenName: tokenNameFieldState.value,
        ),
      );
    }
  }

  return InfluencerTokenScreenState(
    symbolFieldState: tokenFieldState,
    tokenFieldState: tokenNameFieldState,
    onProceed: onProceed,
  );
}
