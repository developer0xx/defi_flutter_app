import 'package:sapiency_app/screen/auth/reset_password/auth_reset_password_flow.dart';
import 'package:sapiency_app/screen/auth/sign_in/auth_sign_in_screen.dart';
import 'package:sapiency_app/screen/auth/sign_up/auth_sign_up_flow.dart';
import 'package:sapiency_app/screen/auth/welcome/welcome_screen.dart';
import 'package:sapiency_app/screen/crowdsale/crowdsale_screen.dart';
import 'package:sapiency_app/screen/influencer/flow/influencer_flow.dart';
import 'package:sapiency_app/screen/main/main_screen.dart';
import 'package:sapiency_app/screen/payment/payment_screen.dart';
import 'package:sapiency_app/screen/profile/edit/edit_profile_screen.dart';
import 'package:sapiency_app/screen/profile/profile_screen.dart';
import 'package:sapiency_app/screen/splash/splash_screen.dart';
import 'package:sapiency_app/screen/splash/update_screen.dart';
import 'package:sapiency_app/screen/util/qr_scanner/qr_scanner_screen.dart';
import 'package:sapiency_app/screen/wallet/subscreens/receive/wallet_receive_screen.dart';
import 'package:sapiency_app/screen/wallet/subscreens/send/confirmation/wallet_send_confirmation_screen.dart';
import 'package:sapiency_app/screen/wallet/subscreens/send/success/wallet_send_success_screen.dart';
import 'package:sapiency_app/screen/wallet/subscreens/send/wallet_send_screen.dart';
import 'package:sapiency_app/screen/wallet/wallet_page.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';

class AppRouting {
  static final routes = <String, RouteConfig>{
    SplashScreen.route: SplashScreen.routeConfig,
    WalletPage.route: WalletPage.routeConfig,
    WalletSendScreen.route: WalletSendScreen.routeConfig,
    WalletSendConfirmationScreen.route: WalletSendConfirmationScreen.routeConfig,
    WalletSendSuccessScreen.route: WalletSendSuccessScreen.routeConfig,
    WalletReceiveScreen.route: WalletReceiveScreen.routeConfig,
    AuthSignUpFlow.route: AuthSignUpFlow.routeConfig,
    InfluencerFlow.route: InfluencerFlow.routeConfig,
    MainScreen.route: MainScreen.routeConfig,
    AuthSignInScreen.route: AuthSignInScreen.routeConfig,
    AuthResetPasswordFlow.route: AuthResetPasswordFlow.routeConfig,
    WelcomeScreen.route: WelcomeScreen.routeConfig,
    CrowdsaleScreen.route: CrowdsaleScreen.routeConfig,
    PaymentScreen.route: PaymentScreen.routeConfig,
    ProfileScreen.route: ProfileScreen.routeConfig,
    EditProfileScreen.route: EditProfileScreen.routeConfig,
    UpdateAppScreen.route: UpdateAppScreen.routeConfig,
    QrScannerScreen.route: QrScannerScreen.routeConfig,
  };

  static const initialRoute = SplashScreen.route;
}
