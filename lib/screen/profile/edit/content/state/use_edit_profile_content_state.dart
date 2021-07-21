import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:sapiency_app/app/state/user/user_state.dart';
import 'package:sapiency_app/common/state/submit/use_submit_state.dart';
import 'package:sapiency_app/common/state/upload/upload_state.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';
import 'package:sapiency_app/model/user/input/user_input.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';

class EditProfileContentState {
  final FieldState descriptionState;
  final UploadState uploadState;
  final SubmitState submitState;
  final bool isButtonEnabled;

  const EditProfileContentState({
    required this.descriptionState,
    required this.uploadState,
    required this.submitState,
    required this.isButtonEnabled,
  });
}

EditProfileContentState useEditProfileContentState({
  Function()? onComplete,
  required bool areFieldsRequired,
}) {
  final userState = useProvided<UserState>();
  final user = userState.user!.public;

  final descriptionFieldState = useFieldStateSimple(initialValue: user.description);

  pickFile() async => File((await ImagePicker().getImage(source: ImageSource.gallery))!.path);

  final uploadState = useUploadState(
    uploadPrefix: "${user.nickname}/profile-picture",
    pickFile: pickFile,
    initialUrl: user.imageUrl,
  );

  final submitState = useSubmitStateSimple(
      performSubmit: () async {
        await userState.update(
          UserInput(
            nickname: user.nickname,
            description: descriptionFieldState.value,
            imageUrl: uploadState.pickedUrl,
          ),
        );
        await userState.refresh();
      },
      afterSubmit: (_) => onComplete?.call());

  return EditProfileContentState(
    descriptionState: descriptionFieldState,
    submitState: submitState,
    uploadState: uploadState,
    isButtonEnabled: !areFieldsRequired || (descriptionFieldState.isNotEmpty && uploadState.pickedUrl != null),
  );
}
