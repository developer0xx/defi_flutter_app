import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/app/state/user/user_state.dart';
import 'package:sapiency_app/common/state/submit/use_submit_state.dart';
import 'package:sapiency_app/di/injector.dart';
import 'package:sapiency_app/model/crowdsale/computed/crowdsale_computed_data.dart';
import 'package:sapiency_app/model/crowdsale/input/crowdsale_input.dart';
import 'package:sapiency_app/model/influencer/input/influencer_input.dart';
import 'package:sapiency_app/screen/influencer/flow/influencer_flow_state.dart';
import 'package:sapiency_app/service/crowdsale/computed/crowdsale_computed_data_service.dart';
import 'package:sapiency_app/service/influencer/influencer_service.dart';
import 'package:sapiency_app/util/extension/extensions.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';
import 'package:sapiency_app/util/hook/use_togglable_bool.dart';

class InfluencerSummaryScreenState {
  final TogglableBoolState confirmationSwitcherState;
  final TogglableBoolState agreementSwitcherState;
  final InfluencerInput influencer;
  final CrowdsaleInput? crowdsale;
  final CrowdsaleComputedData? crowdsaleComputedData;
  final SubmitState submitState;
  final bool isButtonEnabled;

  const InfluencerSummaryScreenState({
    required this.confirmationSwitcherState,
    required this.agreementSwitcherState,
    required this.influencer,
    required this.crowdsale,
    required this.crowdsaleComputedData,
    required this.submitState,
    required this.isButtonEnabled,
  });
}

InfluencerSummaryScreenState useInfluencerSummaryScreenState({
  required Function() navigateToDone,
}) {
  final influencerService = useInjected<InfluencerService>();
  final crowdsaleComputedDataService = useInjected<CrowdsaleComputedDataService>();
  final userState = useProvided<UserState>();
  final flowState = useProvided<InfluencerFlowState>();

  final confirmationSwitcherState = useTogglableBool(false);
  final agreementSwitcherState = useTogglableBool(false);

  final submitState = useSubmitStateSimple(
    performSubmit: () async => await influencerService.setup(flowState.influencer, flowState.crowdsale),
    afterSubmit: (_) async {
      await userState.refresh();
      navigateToDone();
    },
  );

  final crowdsaleComputedData = useMemoized(
    () => flowState.crowdsale?.let((it) => crowdsaleComputedDataService.compute(it)),
    [flowState.crowdsale],
  );

  return InfluencerSummaryScreenState(
    confirmationSwitcherState: confirmationSwitcherState,
    agreementSwitcherState: agreementSwitcherState,
    influencer: flowState.influencer,
    crowdsale: flowState.crowdsale,
    crowdsaleComputedData: crowdsaleComputedData,
    submitState: submitState,
    isButtonEnabled: agreementSwitcherState.value && confirmationSwitcherState.value,
  );
}
