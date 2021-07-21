import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/model/crowdsale/input/crowdsale_input.dart';
import 'package:sapiency_app/model/influencer/input/influencer_input.dart';

import 'influencer_flow_args.dart';

class InfluencerFlowState {
  final InfluencerInput influencer;
  final CrowdsaleInput? crowdsale;

  final Function(InfluencerInput) onInfluencerUpdated;
  final Function(CrowdsaleInput?) onCrowdsaleUpdated;
  final Function() onComplete;

  const InfluencerFlowState({
    required this.influencer,
    required this.crowdsale,
    required this.onInfluencerUpdated,
    required this.onCrowdsaleUpdated,
    required this.onComplete,
  });
}

InfluencerFlowState useInfluencerFlowState({required InfluencerFlowArgs args}) {
  final influencerState = useState<InfluencerInput>(InfluencerInput());
  final crowdsaleState = useState<CrowdsaleInput?>(null);

  return InfluencerFlowState(
    influencer: influencerState.value,
    crowdsale: crowdsaleState.value,
    onInfluencerUpdated: (value) => influencerState.value = value,
    onCrowdsaleUpdated: (value) => crowdsaleState.value = value,
    onComplete: args.onComplete,
  );
}
