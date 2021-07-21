import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/influencer/metatags/influencer_metatags_screen.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';
import './state/influencer_media_screen_state.dart';
import './view/influencer_media_screen_view.dart';

class InfluencerMediaScreen extends HookWidget {
  static const route = '/influencer/media';
  static final routeConfig = RouteConfig.enterExit(() => InfluencerMediaScreen());
  static final int step = 3;

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final state = useInfluencerMediaScreenState(
      navigateToMetatags: () => navigator.pushNamed(InfluencerMetatagsScreen.route),
    );

    return InfluencerMediaScreenView(state: state);
  }
}
