import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';

import 'state/use_auth_sign_up_confirm_email_screen_state.dart';
import 'view/auth_sign_up_confirm_email_screen_view.dart';

class AuthSignUpConfirmEmailScreen extends HookWidget {
  static const route = '/auth/sign_up/confirm_email';
  static final routeConfig = RouteConfig.material(() => AuthSignUpConfirmEmailScreen());

  @override
  Widget build(BuildContext context) {
    final state = useAuthSignUpConfirmEmailScreenState();
    return AuthSignUpConfirmEmailScreenView(state: state);
  }
}
