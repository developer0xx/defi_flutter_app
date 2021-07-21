import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/main/main_screen.dart';
import 'package:sapiency_app/screen/wallet/subscreens/send/confirmation/state/wallet_send_confirmation_screen_args.dart';
import 'package:sapiency_app/screen/wallet/subscreens/send/success/wallet_send_success_screen.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';
import './state/use_wallet_send_confirmation_screen_state.dart';
import './view/wallet_send_confirmation_screen_view.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class WalletSendConfirmationScreen extends HookWidget {
  static const route = '/wallet/send/confirmation';
  static final routeConfig = RouteConfig.material(() => WalletSendConfirmationScreen());

  @override
  Widget build(BuildContext context) {
    final args = context.routeArgs<WalletSendConfirmationScreenArgs>()!;
    final navigator = useScopedNavigator();
    final state = useWalletSendConfirmationScreenState(
      args: args,
      navigateToSuccess: () => navigator.pushNamedAndRemoveUntil(
        WalletSendSuccessScreen.route,
        ModalRoute.withName(MainScreen.route),
      ),
    );
    return WalletSendConfirmationScreenView(state: state);
  }
}
