import 'package:sapiency_app/screen/profile/edit/content/state/use_edit_profile_content_state.dart';

class InfluencerProfileScreenState {
  final EditProfileContentState editState;

  const InfluencerProfileScreenState({
    required this.editState,
  });
}

InfluencerProfileScreenState useInfluencerProfileScreenState({required Function() navigateToInfo}) {
  final editState = useEditProfileContentState(onComplete: navigateToInfo, areFieldsRequired: true);

  return InfluencerProfileScreenState(editState: editState);
}
