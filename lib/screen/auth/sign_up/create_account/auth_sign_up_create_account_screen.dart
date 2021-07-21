import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/auth/sign_up/confirm_email/auth_sign_up_confirm_email_screen.dart';
import 'package:sapiency_app/screen/auth/sign_up/create_account/view/widgets/terms_bottom_sheet/auth_sign_up_create_account_terms_bottom_sheet.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';

import 'state/use_auth_sign_up_create_account_screen_state.dart';
import 'view/auth_sign_up_create_account_screen_view.dart';

class AuthSignUpCreateAccountScreen extends HookWidget {
  static const route = '/auth/sign_up/create_account';
  static final routeConfig = RouteConfig.material(() => AuthSignUpCreateAccountScreen());

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final state = useAuthSignUpCreateAccountScreenState(
      moveToConfirmEmail: () => navigator.pushNamed(AuthSignUpConfirmEmailScreen.route),
      showTermsBottomSheet: (context, onClosed) => AuthSignUpCreateAccountTermsBottomSheet.show(
        context,
        onClosed: onClosed,
      ),
    );
    return AuthSignUpCreateAccountScreenView(state: state);
  }
}
