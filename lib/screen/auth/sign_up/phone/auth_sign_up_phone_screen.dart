import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';

import './state/use_auth_sign_up_phone_screen_state.dart';
import './view/auth_sign_up_phone_screen_view.dart';
import 'package:sapiency_app/screen/auth/sign_up/confirm_phone/auth_sign_up_confirm_phone_screen.dart';

class AuthSignUpPhoneScreen extends HookWidget {
  static const route = '/auth/sign_up/phone';
  static final routeConfig = RouteConfig.material(() => AuthSignUpPhoneScreen());

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final state = useAuthSignUpPhoneScreenState(
      moveToConfirmPhone: () => navigator.pushNamed(AuthSignUpConfirmPhoneScreen.route),
    );
    return AuthSignUpPhoneScreenView(state: state);
  }
}
