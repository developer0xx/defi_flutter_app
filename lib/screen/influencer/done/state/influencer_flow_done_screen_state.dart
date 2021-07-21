import 'package:sapiency_app/screen/influencer/flow/influencer_flow_state.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';

class InfluencerFlowDoneScreenState {
  final Function() onProceed;

  const InfluencerFlowDoneScreenState({
    required this.onProceed,
  });
}

InfluencerFlowDoneScreenState useInfluencerFlowDoneScreenState() {
  final flowState = useProvided<InfluencerFlowState>();
  return InfluencerFlowDoneScreenState(
    onProceed: flowState.onComplete,
  );
}
