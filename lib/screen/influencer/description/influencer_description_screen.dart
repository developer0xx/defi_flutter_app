import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/influencer/summary/influencer_summary_screen.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';
import './state/influencer_description_screen_state.dart';
import './view/influencer_description_screen_view.dart';

class InfluencerDescriptionScreen extends HookWidget {
  static const route = '/influencer/description';
  static final routeConfig = RouteConfig.enterExit(() => InfluencerDescriptionScreen());
  static final int step = 7;

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final state = useInfluencerDescriptionScreenState(
      navigateToSummary: () => navigator.pushNamed(InfluencerSummaryScreen.route),
    );
    return InfluencerDescriptionScreenView(state: state);
  }
}
