import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:sapiency_app/navigator/scoped_navigator_state.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/auth/reset_password/auth_reset_password_flow_routing.dart';
import 'package:sapiency_app/screen/main/main_screen.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';
import 'package:sapiency_app/util/widget/navigator/nested_navigator.dart';

import 'state/use_auth_reset_password_flow_state.dart';

class AuthResetPasswordFlow extends HookWidget {
  static const route = '/auth/reset_password';
  static final routeConfig = RouteConfig.material(() => AuthResetPasswordFlow());

  @override
  Widget build(BuildContext context) {
    final parentNavigator = useScopedNavigator();
    final navigatorKey = useMemoized(() => GlobalKey<NavigatorState>());

    final state = useAuthResetPasswordFlowState(
      moveToHome: () => parentNavigator.pushNamedAndRemoveUntil(MainScreen.route, (_) => false),
    );

    return MultiProvider(
      providers: [
        Provider<AuthResetPasswordFlowState>.value(value: state),
        Provider<ScopedNavigatorState>.value(value: ScopedNavigatorState(navigatorKey: navigatorKey)),
      ],
      child: NestedNavigator(
        navigatorKey: navigatorKey,
        parentNavigator: parentNavigator,
        routes: AuthResetPasswordFlowRouting.routes,
        initialRoute: AuthResetPasswordFlowRouting.initialRoute,
      ),
    );
  }
}
