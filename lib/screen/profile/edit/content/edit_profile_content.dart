import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/common/widgets/avatar/user_avatar.dart';
import 'package:sapiency_app/common/widgets/button/button.dart';
import 'package:sapiency_app/common/widgets/input/app_text_input.dart';
import 'package:sapiency_app/common/widgets/upload/upload_wrapper.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';
import 'package:sapiency_app/screen/profile/edit/content/state/use_edit_profile_content_state.dart';

class EditProfileContent extends StatelessWidget {
  final EditProfileContentState state;
  final String title;
  final String subtitle;
  final String buttonTitle;
  final Future Function()? afterSubmit;

  const EditProfileContent({
    required this.state,
    required this.title,
    required this.subtitle,
    required this.buttonTitle,
    this.afterSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        _buildTitle(context),
        _buildSubtitle(context),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: _buildContent(context),
        ),
        _buildButton(context),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: AppText.title,
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      subtitle,
      style: AppText.subtitle,
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.strings.inf.profile.label.profilePicture, style: AppText.label),
        SizedBox(height: 8),
        FileUploadWrapper(
          height: 100,
          width: 100,
          state: state.uploadState,
          child: UserAvatar(
            size: 100,
            avatarUrl: state.uploadState.pickedUrl,
            onTap: state.uploadState.onUploadPressed,
          ),
        ),
        SizedBox(height: 16),
        AppTextInput(
          keyboardType: TextInputType.multiline,
          state: state.descriptionState,
          label: context.strings.inf.profile.label.description,
          hintText: context.strings.inf.profile.hint.description,
          maxLines: 5,
          maxLength: 200,
          textInputAction: TextInputAction.newline,
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return Button(
      text: buttonTitle,
      loading: state.submitState.isSubmitInProgress,
      onPressed: () async {
        await state.submitState.onSubmitPressed();
        if (afterSubmit != null) await afterSubmit!();
      },
    );
  }
}
