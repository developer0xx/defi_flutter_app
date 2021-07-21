import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/util/qr_scanner/qr_scanner_screen.dart';
import 'package:sapiency_app/screen/wallet/subscreens/send/confirmation/wallet_send_confirmation_screen.dart';
import 'package:sapiency_app/screen/wallet/subscreens/send/state/wallet_send_screen_args.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';
import './state/use_wallet_send_screen_state.dart';
import './view/wallet_send_screen_view.dart';
import 'package:sapiency_app/util/extension/extensions.dart';

class WalletSendScreen extends HookWidget {
  static const route = '/wallet/send';
  static final routeConfig = RouteConfig.material(() => WalletSendScreen());

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final args = context.routeArgs<WalletSendScreenArgs>()!;
    final state = useWalletSendScreenState(
      wallet: args.wallet,
      navigateToConfirmation: (args) => navigator.pushNamed(WalletSendConfirmationScreen.route, arguments: args),
      navigateToScanner: () => navigator.pushNamed(QrScannerScreen.route),
    );
    return WalletSendScreenView(state: state);
  }
}
