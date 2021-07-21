import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/common/widgets/snackbar/snackbars.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/wallet/subscreens/receive/wallet_receive_screen.dart';
import 'package:sapiency_app/screen/wallet/subscreens/send/state/wallet_send_screen_args.dart';
import 'package:sapiency_app/screen/wallet/subscreens/send/wallet_send_screen.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';
import './state/wallet_page_state.dart';
import './view/wallet_page_view.dart';

class WalletPage extends HookWidget {
  static const route = '/wallet';
  static final routeConfig = RouteConfig.material(() => WalletPage());

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final state = useWalletPageState(
      navigateToSend: (wallet) =>
          navigator.pushNamed(WalletSendScreen.route, arguments: WalletSendScreenArgs(wallet: wallet)),
      navigateToReceive: () => navigator.pushNamed(WalletReceiveScreen.route),
      showComingSoonSnackBar: () => SnackBars.showComingSoon(context),
    );
    return WalletPageView(state: state);
  }
}
