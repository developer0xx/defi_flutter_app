import 'package:sapiency_app/screen/profile/edit/content/state/use_edit_profile_content_state.dart';

class EditProfileScreenState {
  final EditProfileContentState editState;

  const EditProfileScreenState({required this.editState});
}

EditProfileScreenState useEditProfileScreenState() {
  final editState = useEditProfileContentState(areFieldsRequired: false);

  return EditProfileScreenState(editState: editState);
}
