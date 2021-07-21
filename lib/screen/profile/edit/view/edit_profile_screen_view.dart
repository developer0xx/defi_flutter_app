import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/common/widgets/submit/submit_wrapper.dart';
import 'package:sapiency_app/screen/profile/edit/content/edit_profile_content.dart';
import 'package:sapiency_app/screen/profile/edit/state/use_edit_profile_screen_state.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class EditProfileScreenView extends StatelessWidget {
  final EditProfileScreenState state;

  const EditProfileScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SubmitWrapper(
        state: state.editState.submitState,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: SvgPicture.asset(AppImages.textLogo),
          ),
          backgroundColor: AppColors.background,
          body: Padding(
            padding: AppValues.screenPadding,
            child: EditProfileContent(
              state: state.editState,
              title: context.strings.profile.edit.title,
              subtitle: context.strings.profile.edit.subtitle,
              buttonTitle: context.strings.common.save,
              afterSubmit: () async => Navigator.pop(context),
            ),
          ),
        ),
      ),
    );
  }
}
