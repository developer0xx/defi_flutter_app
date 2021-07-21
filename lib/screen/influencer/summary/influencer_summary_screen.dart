import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/influencer/done/influencer_flow_done_screen.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';
import './state/influencer_summary_screen_state.dart';
import './state/influencer_summary_screen_state.dart';
import './view/influencer_summary_screen_view.dart';

class InfluencerSummaryScreen extends HookWidget {
  static const route = '/influencer/summary';
  static final routeConfig = RouteConfig.enterExit(() => InfluencerSummaryScreen());
  static const step = 8;

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();

    final state = useInfluencerSummaryScreenState(
      navigateToDone: () => navigator.pushNamed(InfluencerFlowDoneScreen.route),
    );
    return InfluencerSummaryScreenView(state: state);
  }
}
