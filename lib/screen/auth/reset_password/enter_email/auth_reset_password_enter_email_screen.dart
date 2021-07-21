import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/auth/reset_password/set_new/auth_reset_password_set_new_screen.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';

import './state/use_auth_reset_password_enter_email_screen_state.dart';
import './view/auth_reset_password_enter_email_screen_view.dart';

class AuthResetPasswordEnterEmailScreen extends HookWidget {
  static const route = '/auth/reset_password/enter_email';
  static final routeConfig = RouteConfig.material(() => AuthResetPasswordEnterEmailScreen());

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final state = useAuthResetPasswordEnterEmailScreenState(
      moveToSetNewPassword: () => navigator.pushNamed(AuthResetPasswordSetNewScreen.route),
    );
    return AuthResetPasswordEnterEmailScreenView(state: state);
  }
}
