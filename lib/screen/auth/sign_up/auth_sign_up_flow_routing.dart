import 'package:sapiency_app/screen/auth/sign_up/confirm_email/auth_sign_up_confirm_email_screen.dart';
import 'package:sapiency_app/screen/auth/sign_up/create_account/auth_sign_up_create_account_screen.dart';
import 'package:sapiency_app/screen/auth/sign_up/phone/auth_sign_up_phone_screen.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';
import 'package:sapiency_app/screen/auth/sign_up/confirm_phone/auth_sign_up_confirm_phone_screen.dart';

class AuthSignUpFlowRouting {
  static final routes = <String, RouteConfig>{
    AuthSignUpCreateAccountScreen.route: AuthSignUpCreateAccountScreen.routeConfig,
    AuthSignUpConfirmEmailScreen.route: AuthSignUpConfirmEmailScreen.routeConfig,
    AuthSignUpPhoneScreen.route: AuthSignUpPhoneScreen.routeConfig,
    AuthSignUpConfirmPhoneScreen.route: AuthSignUpConfirmPhoneScreen.routeConfig,
  };

  static const initialRoute = AuthSignUpCreateAccountScreen.route;
}
