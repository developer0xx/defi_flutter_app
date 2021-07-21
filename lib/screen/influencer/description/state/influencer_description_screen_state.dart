import 'dart:io';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sapiency_app/app/state/user/user_state.dart';
import 'package:sapiency_app/common/state/upload/upload_state.dart';
import 'package:sapiency_app/common/widgets/input/input_validator.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';
import 'package:sapiency_app/di/injector.dart';
import 'package:sapiency_app/screen/influencer/flow/influencer_flow_state.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';

class InfluencerDescriptionScreenState {
  final FieldState titleFieldState;
  final FieldState descriptionFieldState;
  final bool isButtonEnabled;
  final UploadState uploadState;

  final Function() onProceed;

  const InfluencerDescriptionScreenState({
    required this.titleFieldState,
    required this.descriptionFieldState,
    required this.onProceed,
    required this.isButtonEnabled,
    required this.uploadState,
  });
}

InfluencerDescriptionScreenState useInfluencerDescriptionScreenState({
  required Function() navigateToSummary,
}) {
  final userState = useProvided<UserState>();
  final flowState = useProvided<InfluencerFlowState>();
  final crowdsale = flowState.crowdsale!; // note: without crowdsale, user won't enter this screen

  final titleFieldState = useFieldStateSimple(initialValue: crowdsale.title);
  final descriptionFieldState = useFieldStateSimple(initialValue: crowdsale.description);

  pickFile() async => File((await ImagePicker().getImage(source: ImageSource.gallery))!.path);

  final uploadState = useUploadState(
    initialUrl: crowdsale.coverUrl,
    uploadPrefix: "${userState.user!.public.nickname}/crowdsale-cover",
    pickFile: pickFile,
  );

  bool validate() {
    final titleError = titleFieldState.validate((value) => InputValidator.validateRequiredInput(value));
    final descriptionError = descriptionFieldState.validate((value) => InputValidator.validateRequiredInput(value));

    return titleError == null && descriptionError == null;
  }

  onProceed() {
    if (validate()) {
      flowState.onCrowdsaleUpdated(
        crowdsale.copyWith(
          title: titleFieldState.value,
          description: descriptionFieldState.value,
          coverUrl: uploadState.pickedUrl,
        ),
      );
      navigateToSummary();
    }
  }

  return InfluencerDescriptionScreenState(
    descriptionFieldState: descriptionFieldState,
    titleFieldState: titleFieldState,
    uploadState: uploadState,
    onProceed: onProceed,
    isButtonEnabled: titleFieldState.isNotEmpty && descriptionFieldState.isNotEmpty && uploadState.pickedUrl != null,
  );
}
