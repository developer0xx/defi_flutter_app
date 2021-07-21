import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/model/user/public/public_user.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/influencer/flow/influencer_flow.dart';
import 'package:sapiency_app/screen/influencer/flow/influencer_flow_args.dart';
import 'package:sapiency_app/screen/main/main_screen.dart';
import 'package:sapiency_app/screen/profile/edit/edit_profile_screen.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';
import 'package:sapiency_app/screen/profile/profile_screen_args.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';
import './state/use_profile_screen_state.dart';
import './view/profile_screen_view.dart';

class ProfileScreen extends HookWidget {
  static const route = '/profile';
  static final routeConfig = RouteConfig.material(() => ProfileScreen());

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final args = context.routeArgs<ProfileScreenArgs>();
    /// args.user == null current user is taken
    final state = useProfileScreenState(
      user: args?.user,
      navigateToEdit: () => navigator.pushNamed(EditProfileScreen.route),
      navigateToInfluencerFlow: () => navigator.pushNamed(
        InfluencerFlow.route,
        arguments: InfluencerFlowArgs(
          onComplete: () => navigator.popUntil(ModalRoute.withName(MainScreen.route)),
        ),
      ),
    );
    return ProfileScreenView(state: state);
  }
}
