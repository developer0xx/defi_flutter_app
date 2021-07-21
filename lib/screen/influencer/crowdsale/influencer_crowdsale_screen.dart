import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/influencer/description/influencer_description_screen.dart';
import 'package:sapiency_app/screen/influencer/summary/influencer_summary_screen.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';
import './state/influencer_crowdsale_screen_state.dart';
import './view/influencer_crowdsale_screen_view.dart';

class InfluencerCrowdsaleScreen extends HookWidget {
  static const route = '/influencer/crowdsale';
  static final routeConfig = RouteConfig.enterExit(() => InfluencerCrowdsaleScreen());
  static final int step = 6;

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final state = useInfluencerCrowdsaleScreenState(
      navigateToDescription: () => navigator.pushNamed(InfluencerDescriptionScreen.route),
      navigateToSummary: () => navigator.pushNamed(InfluencerSummaryScreen.route),
    );
    return InfluencerCrowdsaleScreenView(state: state);
  }
}
