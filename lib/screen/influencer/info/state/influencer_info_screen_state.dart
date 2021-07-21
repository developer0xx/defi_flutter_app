import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/common/widgets/input/date_input/date_input_helper.dart';
import 'package:sapiency_app/common/widgets/input/input_validator.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';
import 'package:sapiency_app/screen/influencer/flow/influencer_flow_state.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';

class InfluencerInfoScreenState {
  final FieldState nameFieldState;
  final FieldState surnameFieldState;
  final FieldState birthdayFieldState;
  final bool isButtonEnabled;
  final Function() onProceed;

  const InfluencerInfoScreenState({
    required this.nameFieldState,
    required this.surnameFieldState,
    required this.birthdayFieldState,
    required this.isButtonEnabled,
    required this.onProceed,
  });
}

InfluencerInfoScreenState useInfluencerInfoScreenState(Function() navigateToMedia) {
  final flowState = useProvided<InfluencerFlowState>();
  final influencer = flowState.influencer;

  final birthdayFieldState = useFieldStateSimple();
  final surnameFieldState = useFieldStateSimple();
  final nameFieldState = useFieldStateSimple();

  bool validate() {
    final birthdayError = birthdayFieldState.validate((value) => InputValidator.validateDateInput(value));
    final nameError = nameFieldState.validate((value) => InputValidator.validateRequiredInput(value));
    final surnameError = surnameFieldState.validate((value) => InputValidator.validateRequiredInput(value));

    return birthdayError == null && nameError == null && surnameError == null;
  }

  onProceed() {
    if (validate()) {
      navigateToMedia();
      flowState.onInfluencerUpdated(
        influencer.copyWith(
          dateOfBirth: DateHelper.formatDMY.parse(birthdayFieldState.value),
          lastName: surnameFieldState.value,
          firstName: nameFieldState.value,
        ),
      );
    }
  }

  return InfluencerInfoScreenState(
    nameFieldState: nameFieldState,
    birthdayFieldState: birthdayFieldState,
    surnameFieldState: surnameFieldState,
    isButtonEnabled: nameFieldState.isNotEmpty && surnameFieldState.isNotEmpty && birthdayFieldState.isNotEmpty,
    onProceed: onProceed,
  );
}
