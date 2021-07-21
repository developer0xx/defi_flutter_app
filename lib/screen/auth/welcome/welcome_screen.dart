import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/auth/sign_in/auth_sign_in_screen.dart';
import 'package:sapiency_app/screen/auth/sign_up/auth_sign_up_flow.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';

import './state/welcome_screen_state.dart';
import './view/welcome_screen_view.dart';

class WelcomeScreen extends HookWidget {
  static const route = '/welcome';
  static final routeConfig = RouteConfig.material(() => WelcomeScreen());

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final state = useWelcomeScreenState(
      navigateToSignIn: () => navigator.pushNamed(AuthSignInScreen.route),
      navigateToSignUp: () => navigator.pushNamed(AuthSignUpFlow.route),
    );
    return WelcomeScreenView(state: state);
  }
}
