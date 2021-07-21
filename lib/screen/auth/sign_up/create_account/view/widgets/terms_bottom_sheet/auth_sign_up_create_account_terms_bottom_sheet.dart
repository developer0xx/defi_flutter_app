import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';

import 'state/use_auth_sign_up_create_account_terms_bottom_sheet_state.dart';
import 'view/auth_sign_up_create_account_terms_bottom_sheet_view.dart';

class AuthSignUpCreateAccountTermsBottomSheet extends HookWidget {
  final Function(List<String> consents) onClosed;

  AuthSignUpCreateAccountTermsBottomSheet(this.onClosed);

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final state = useAuthSignUpCreateAccountScreenTermsBottomSheetState(close: (consents) {
      onClosed(consents);
      navigator.pop();
    });
    return AuthSignUpCreateAccountTermsBottomSheetView(state: state);
  }

  static Future<void> show(BuildContext context, {required Function(List<String> consents) onClosed}) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => AuthSignUpCreateAccountTermsBottomSheet(onClosed),
    );
  }
}
