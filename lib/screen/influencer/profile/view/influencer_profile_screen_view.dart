import 'package:flutter/widgets.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/widgets/avatar/user_avatar.dart';
import 'package:sapiency_app/common/widgets/input/app_text_input.dart';
import 'package:sapiency_app/common/widgets/upload/upload_wrapper.dart';
import 'package:sapiency_app/screen/influencer/widget/influencer_view_layout.dart';
import 'package:sapiency_app/screen/profile/edit/content/edit_profile_content.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

import '../influencer_profile_screen.dart';
import '../state/influencer_profile_screen_state.dart';

class InfluencerProfileScreenView extends StatelessWidget {
  final InfluencerProfileScreenState state;

  const InfluencerProfileScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return InfluencerViewLayout(
      progressTitle: context.strings.inf.profile.progressTitle,
      step: InfluencerProfileScreen.step,
      hasButton: false,
      child: EditProfileContent(
        buttonTitle: context.strings.common.next,
        title: context.strings.inf.profile.title,
        subtitle: context.strings.inf.profile.subtitle,
        state: state.editState,
      ),
      onProceed: state.editState.submitState.onSubmitPressed,
    );
  }
}
