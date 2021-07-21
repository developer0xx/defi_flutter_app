import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:sapiency_app/common/widgets/input/app_text_input.dart';
import 'package:sapiency_app/screen/influencer/widget/influencer_view_layout.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';
import '../influencer_token_screen.dart';
import '../state/influencer_token_screen_state.dart';

class InfluencerTokenScreenView extends StatelessWidget {
  final InfluencerTokenScreenState state;

  const InfluencerTokenScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return InfluencerViewLayout(
      title: context.strings.inf.tokenInfo.title,
      subtitle: context.strings.inf.tokenInfo.subtitle,
      progressTitle: context.strings.inf.tokenInfo.progressTitle,
      step: InfluencerTokenScreen.step,
      child: _buildFields(context),
      onProceed: state.onProceed,
    );
  }

  Widget _buildFields(BuildContext context) {
    return Column(
      children: [
        AppTextInput(
          state: state.tokenFieldState,
          label: context.strings.inf.tokenInfo.label.tokenName,
          textInputAction: TextInputAction.next,
          onSubmitFocusChanged: state.symbolFieldState.requestFocus,
        ),
        AppTextInput(
          state: state.symbolFieldState,
          label: context.strings.inf.tokenInfo.label.tokenSymbol,
          linkText: context.strings.inf.tokenInfo.information.tokenSymbol,
          maxLength: 8,
        ),
      ],
    );
  }
}
