import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/common/widgets/input/input_validator.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';
import 'package:sapiency_app/screen/influencer/flow/influencer_flow_state.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';
import 'package:sapiency_app/util/extension/list_extensions.dart';


class InfluencerMetatagsScreenState {
  final List<String> tags;
  final FieldState fieldState;
  final Function(String) onTagAdded;
  final Function(String) onTagRemoved;
  final Function() onProceed;
  final bool isFieldEnabled;

  const InfluencerMetatagsScreenState({
    required this.tags,
    required this.onTagAdded,
    required this.onTagRemoved,
    required this.onProceed,
    required this.fieldState,
    required this.isFieldEnabled,
  });
}

InfluencerMetatagsScreenState useInfluencerMetatagsScreenState({required Function() navigateToToken}) {
  final flowState = useProvided<InfluencerFlowState>();
  final influencer = flowState.influencer;

  final tagState = useState<List<String>>(influencer.metaTags ?? []);
  final fieldState = useFieldStateSimple();

  onProceed() {
    final error = fieldState.validate((value) => InputValidator.validateMetatagsInput(tagState.value));
    if (error == null) {
      navigateToToken();
      flowState.onInfluencerUpdated(influencer.copyWith(metaTags: tagState.value));
    }
  }

  return InfluencerMetatagsScreenState(
      tags: tagState.value,
      fieldState: fieldState,
      onProceed: onProceed,
      isFieldEnabled: tagState.value.length < 3,
      onTagAdded: (tag) {
        if (!tagState.value.contains(tag) && tag.isNotEmpty) tagState.value = tagState.value.plus([tag]);
      },
      onTagRemoved: (tag) => tagState.value = tagState.value.minus([tag]));
}
