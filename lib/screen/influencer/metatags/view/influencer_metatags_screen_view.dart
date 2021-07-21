import 'package:flutter/widgets.dart';
import 'package:sapiency_app/common/widgets/tags/metatags_field.dart';
import 'package:sapiency_app/screen/influencer/widget/influencer_view_layout.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';
import '../influencer_metatags_screen.dart';
import '../state/influencer_metatags_screen_state.dart';

class InfluencerMetatagsScreenView extends StatelessWidget {
  final InfluencerMetatagsScreenState state;

  const InfluencerMetatagsScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return InfluencerViewLayout(
      title: context.strings.inf.metatags.title,
      subtitle: context.strings.inf.metatags.subtitle,
      progressTitle: context.strings.inf.metatags.progressTitle,
      step: InfluencerMetatagsScreen.step,
      child: MetatagsField(
        isEnabled: state.isFieldEnabled,
        label: context.strings.inf.metatags.label,
        fieldState: state.fieldState,
        tags: state.tags,
        onTagRemoved: state.onTagRemoved,
        onTagAdded: state.onTagAdded,
      ),
      onProceed: state.onProceed,
    );
  }
}
