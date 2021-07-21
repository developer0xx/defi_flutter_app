import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/influencer/info/influencer_info_screen.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';

import 'state/influencer_profile_screen_state.dart';
import 'view/influencer_profile_screen_view.dart';

class InfluencerProfileScreen extends HookWidget {
  static const route = 'influencer/profile';
  static final routeConfig = RouteConfig.enterExit(() => InfluencerProfileScreen());
  static final step = 1;

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();

    final state = useInfluencerProfileScreenState(
      navigateToInfo: () => navigator.pushNamed(InfluencerInfoScreen.route),
    );
    return InfluencerProfileScreenView(state: state);
  }
}
