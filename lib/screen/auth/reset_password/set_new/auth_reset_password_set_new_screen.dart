import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';

import './state/use_auth_reset_password_set_new_screen_state.dart';
import './view/auth_reset_password_set_new_screen_view.dart';

class AuthResetPasswordSetNewScreen extends HookWidget {
  static const route = '/auth/reset_password/set_new';
  static final routeConfig = RouteConfig.material(() => AuthResetPasswordSetNewScreen());

  @override
  Widget build(BuildContext context) {
    final state = useAuthResetPasswordSetNewScreenState();
    return AuthResetPasswordSetNewScreenView(state: state);
  }
}
