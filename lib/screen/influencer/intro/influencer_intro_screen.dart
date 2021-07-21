import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/influencer/profile/influencer_profile_screen.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';
import './state/influencer_intro_screen_state.dart';
import './view/influencer_intro_screen_view.dart';

class InfluencerIntroScreen extends HookWidget {
  static const route = '/influencer/intro';
  static final routeConfig = RouteConfig.enterExit(() => InfluencerIntroScreen());

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final state = useInfluencerIntroScreenState(
          () => navigator.pushNamed(InfluencerProfileScreen.route),
    );
    return InfluencerIntroScreenView(state: state);
  }
}
