import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/common/widgets/snackbar/app_snack_bar.dart';
import 'package:sapiency_app/model/user/public/public_user.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/payment/payment_screen.dart';
import 'package:sapiency_app/screen/payment/payment_screen_args.dart';
import 'package:sapiency_app/screen/payment/payment_screen_result.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

import 'state/crowdsale_contribute_bottom_sheet_state.dart';
import 'view/crowdsale_contribute_bottom_sheet_view.dart';

class CrowdsaleContributeBottomSheet extends HookWidget {
  final PublicUserInfluencer user;
  final BuildContext parentContext;

  CrowdsaleContributeBottomSheet({required this.user, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final state = useCrowdsaleContributeBottomSheetState(
      user: user,
      close: () => navigator.pop(),
      awaitPayment: (url) => navigator.pushNamed<PaymentScreenResult?>(
        PaymentScreen.route,
        arguments: PaymentScreenArgs(paymentUrl: url),
      ),
      showPaymentSuccessSnackbar: () => AppSnackBar.show(
        parentContext,
        content: Text(parentContext.strings.payment.resultSnackbar.success),
      ),
      showPaymentErrorSnackbar: () => AppSnackBar.show(
        parentContext,
        content: Text(parentContext.strings.payment.resultSnackbar.error),
      ),
    );
    return CrowdsaleContributeBottomSheetView(state: state);
  }

  static Future<void> show(BuildContext context, {required PublicUserInfluencer user}) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (_) => CrowdsaleContributeBottomSheet(parentContext: context, user: user),
    );
  }
}
