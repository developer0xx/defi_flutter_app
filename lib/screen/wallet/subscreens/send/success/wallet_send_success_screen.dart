import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/main/main_screen.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';
import './state/use_wallet_send_success_screen_state.dart';
import './view/wallet_send_success_screen_view.dart';

class WalletSendSuccessScreen extends HookWidget {
  static const route = '/wallet/send/success';
  static final routeConfig = RouteConfig.material(() => WalletSendSuccessScreen());

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final state = useWalletSendSuccessScreenState(
      navigateBack: () => navigator.popUntil(ModalRoute.withName(MainScreen.route)),
    );
    return WalletSendSuccessScreenView(state: state);
  }
}
