import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/influencer/token/influencer_token_screen.dart';

import 'package:sapiency_app/util/navigation/route_config.dart';
import './state/influencer_metatags_screen_state.dart';
import './state/influencer_metatags_screen_state.dart';
import './view/influencer_metatags_screen_view.dart';

class InfluencerMetatagsScreen extends HookWidget {
  static const route = '/influencer/metatags';
  static final routeConfig = RouteConfig.enterExit(() => InfluencerMetatagsScreen());
  static final int step = 4;

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();

    final state = useInfluencerMetatagsScreenState(
      navigateToToken: () => navigator.pushNamed(InfluencerTokenScreen.route),
    );

    return InfluencerMetatagsScreenView(state: state);
  }
}
