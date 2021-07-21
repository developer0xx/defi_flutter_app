import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/influencer/media/influencer_media_screen.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';
import './state/influencer_info_screen_state.dart';
import './view/influencer_info_screen_view.dart';

class InfluencerInfoScreen extends HookWidget {
  static const route = '/influencer/personal_information';
  static final routeConfig = RouteConfig.enterExit(() => InfluencerInfoScreen());
  static final int step = 2;

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final state = useInfluencerInfoScreenState(
      () => navigator.pushNamed(InfluencerMediaScreen.route),
    );
    return InfluencerInfoScreenView(state: state);
  }
}
