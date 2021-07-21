import 'package:sapiency_app/screen/auth/reset_password/enter_email/auth_reset_password_enter_email_screen.dart';
import 'package:sapiency_app/screen/auth/reset_password/set_new/auth_reset_password_set_new_screen.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';

class AuthResetPasswordFlowRouting {
  static final routes = <String, RouteConfig> {
    AuthResetPasswordEnterEmailScreen.route: AuthResetPasswordEnterEmailScreen.routeConfig,
    AuthResetPasswordSetNewScreen.route: AuthResetPasswordSetNewScreen.routeConfig,
  };

  static const initialRoute = AuthResetPasswordEnterEmailScreen.route;
}
