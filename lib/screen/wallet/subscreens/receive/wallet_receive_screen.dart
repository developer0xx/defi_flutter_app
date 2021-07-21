import 'package:clipboard/clipboard.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/common/widgets/snackbar/snackbars.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';
import 'package:share/share.dart';
import './state/wallet_receive_screen_state.dart';
import './view/wallet_receive_screen_view.dart';

class WalletReceiveScreen extends HookWidget {
  static const route = '/wallet/receive';
  static final routeConfig = RouteConfig.material(() => WalletReceiveScreen());

  @override
  Widget build(BuildContext context) {
    final state = useWalletReceiveScreenState(
      copyAddress: (context, address) => FlutterClipboard.copy(address).then((value) => SnackBars.showCopied(context)),
      shareAddress: (address) => Share.share(address),
    );
    return WalletReceiveScreenView(state: state);
  }
}
