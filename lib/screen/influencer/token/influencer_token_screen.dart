import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/influencer/crowdsale/influencer_crowdsale_screen.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';
import './state/influencer_token_screen_state.dart';
import './view/influencer_token_screen_view.dart';

class InfluencerTokenScreen extends HookWidget {
  static const route = '/influencer/token';
  static final routeConfig = RouteConfig.enterExit(() => InfluencerTokenScreen());
  static final int step = 5;

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final state = useInfluencerTokenScreenState(
      navigateToCrowdsale: () => navigator.pushNamed(InfluencerCrowdsaleScreen.route),
    );
    return InfluencerTokenScreenView(state: state);
  }
}
