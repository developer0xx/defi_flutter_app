import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:sapiency_app/navigator/scoped_navigator_state.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/auth/sign_in/auth_sign_in_screen.dart';
import 'package:sapiency_app/screen/auth/sign_up/auth_sign_up_flow_routing.dart';
import 'package:sapiency_app/screen/main/main_screen.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';
import 'package:sapiency_app/util/widget/navigator/nested_navigator.dart';

import 'state/use_auth_sign_up_flow_state.dart';

class AuthSignUpFlow extends HookWidget {
  static const route = '/auth/sign_up';
  static final routeConfig = RouteConfig.material(() => AuthSignUpFlow());

  @override
  Widget build(BuildContext context) {
    final parentNavigator = useScopedNavigator();
    final navigatorKey = useMemoized(() => GlobalKey<NavigatorState>());

    final state = useAuthSignUpFlowState(
      moveToHome: () => parentNavigator.pushNamedAndRemoveUntil(MainScreen.route, (_) => false),
      moveToSignIn: () => parentNavigator.pushReplacementNamed(AuthSignInScreen.route),
    );

    return MultiProvider(
      providers: [
        Provider<AuthSignUpFlowState>.value(value: state),
        Provider<ScopedNavigatorState>.value(value: ScopedNavigatorState(navigatorKey: navigatorKey)),
      ],
      child: NestedNavigator(
        navigatorKey: navigatorKey,
        parentNavigator: parentNavigator,
        routes: AuthSignUpFlowRouting.routes,
        initialRoute: AuthSignUpFlowRouting.initialRoute,
      ),
    );
  }
}
