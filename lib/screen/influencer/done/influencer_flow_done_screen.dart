import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';
import './state/influencer_flow_done_screen_state.dart';
import './view/influencer_flow_done_screen_view.dart';

class InfluencerFlowDoneScreen extends HookWidget {
  static const route = '/influencer/done';
  static final routeConfig = RouteConfig.enterExit(() => InfluencerFlowDoneScreen());

  @override
  Widget build(BuildContext context) {
    final state = useInfluencerFlowDoneScreenState();
    return InfluencerFlowDoneScreenView(state: state);
  }
}
