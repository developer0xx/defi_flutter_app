import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:sapiency_app/common/widgets/input/app_text_input.dart';
import 'package:sapiency_app/screen/influencer/description/widget/influencer_description_upload_cover.dart';
import 'package:sapiency_app/screen/influencer/widget/influencer_view_layout.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';
import '../influencer_description_screen.dart';
import '../state/influencer_description_screen_state.dart';

class InfluencerDescriptionScreenView extends StatelessWidget {
  final InfluencerDescriptionScreenState state;

  const InfluencerDescriptionScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return InfluencerViewLayout(
      title: context.strings.inf.description.title,
      subtitle: context.strings.inf.description.subtitle,
      progressTitle: context.strings.inf.description.progressTitle,
      step: InfluencerDescriptionScreen.step,
      child: _buildFields(context),
      onProceed: state.onProceed,
      buttonEnabled: state.isButtonEnabled,
    );
  }

  Widget _buildFields(BuildContext context) {
    return Column(
      children: [
        AppTextInput(
          state: state.titleFieldState,
          label: context.strings.inf.description.label.crowdsale,
          hintText: context.strings.inf.description.hint.title,
          textInputAction: TextInputAction.next,
          onSubmitFocusChanged: state.descriptionFieldState.requestFocus,
        ),
        AppTextInput(
          state: state.descriptionFieldState,
          label: context.strings.inf.description.label.description,
          hintText: context.strings.inf.description.hint.description,
          keyboardType: TextInputType.multiline,
          maxLines: 7,
          textInputAction: TextInputAction.newline,
        ),
        InfluencerDescriptionUploadCover(state: state),
      ],
    );
  }
}
