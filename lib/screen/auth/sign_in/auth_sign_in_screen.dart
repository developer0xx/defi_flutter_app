import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/auth/reset_password/auth_reset_password_flow.dart';
import 'package:sapiency_app/screen/auth/sign_up/auth_sign_up_flow.dart';
import 'package:sapiency_app/screen/main/main_screen.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';

import './state/use_auth_sign_in_screen_state.dart';
import './view/auth_sign_in_screen_view.dart';

class AuthSignInScreen extends HookWidget {
  static const route = '/auth/sign_in';
  static final routeConfig = RouteConfig.material(() => AuthSignInScreen());

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final state = useAuthSignInScreenState(
      moveToSignUp: () => navigator.pushReplacementNamed(AuthSignUpFlow.route),
      moveToResetPassword: () => navigator.pushNamed(AuthResetPasswordFlow.route),
      moveToHome: () => navigator.pushNamedAndRemoveUntil(MainScreen.route, (_) => false),
    );

    return AuthSignInScreenView(state: state);
  }
}
