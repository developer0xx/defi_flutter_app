import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:sapiency_app/common/widgets/input/app_text_input.dart';
import 'package:sapiency_app/screen/influencer/widget/influencer_view_layout.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';
import '../influencer_media_screen.dart';
import '../state/influencer_media_screen_state.dart';

class InfluencerMediaScreenView extends StatelessWidget {
  final InfluencerMediaScreenState state;

  const InfluencerMediaScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return InfluencerViewLayout(
      title: context.strings.inf.socialMedia.title,
      subtitle: context.strings.inf.socialMedia.subtitle,
      progressTitle: context.strings.inf.socialMedia.progressTitle,
      step: InfluencerMediaScreen.step,
      child: _buildFields(context),
      onProceed: () => state.onProceed(),
    );
  }

  Widget _buildFields(BuildContext context) {
    return Column(
      children: [
        AppTextInput(
          state: state.facebookFieldState,
          label: context.strings.inf.socialMedia.label.facebook,
          textInputAction: TextInputAction.next,
          onSubmitFocusChanged: state.twitterFieldState.requestFocus,
        ),
        AppTextInput(
          state: state.twitterFieldState,
          label: context.strings.inf.socialMedia.label.twitter,
          textInputAction: TextInputAction.next,
          onSubmitFocusChanged: state.instagramFieldState.requestFocus,
        ),
        AppTextInput(
          state: state.instagramFieldState,
          label: context.strings.inf.socialMedia.label.instagram,
          textInputAction: TextInputAction.next,
          onSubmitFocusChanged: state.youtubeFieldState.requestFocus,
        ),
        AppTextInput(
          state: state.youtubeFieldState,
          label: context.strings.inf.socialMedia.label.youtube,
          textInputAction: TextInputAction.next,
          onSubmitFocusChanged: state.otherMediaFieldState.requestFocus,
        ),
        AppTextInput(
          state: state.otherMediaFieldState,
          label: context.strings.inf.socialMedia.label.otherMedia,
          hintText: context.strings.inf.socialMedia.hint.otherMedia,
        ),
      ],
    );
  }
}
