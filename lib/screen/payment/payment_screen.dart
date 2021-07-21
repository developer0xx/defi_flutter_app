import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/payment/payment_screen_args.dart';
import 'package:sapiency_app/screen/payment/payment_screen_result.dart';
import 'package:sapiency_app/screen/payment/state/use_payment_screen_state.dart';
import 'package:sapiency_app/screen/payment/view/payment_screen_view.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';

class PaymentScreen extends HookWidget {
  static final route = '/payment';
  static final routeConfig = RouteConfig<PaymentScreenResult?>.material(() => PaymentScreen());

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final state = usePaymentScreenState(
      args: context.routeArgs<PaymentScreenArgs>()!,
      moveBack: (result) => navigator.pop(result),
    );
    return PaymentScreenView(state: state);
  }
}
