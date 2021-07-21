import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sapiency_app/app/app_routing.dart';
import 'package:sapiency_app/app/state/auth/auth_state.dart';
import 'package:sapiency_app/app/state/user/user_state.dart';
import 'package:sapiency_app/common/constants/app_theme.dart';
import 'package:sapiency_app/app/state/setup/setup_state_provider.dart';
import 'package:sapiency_app/di/injector_provider.dart';
import 'package:sapiency_app/localization/localization.dart';
import 'package:sapiency_app/navigator/scoped_navigator_state.dart';
import 'package:provider/provider.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';


class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ScopedNavigatorState>.value(value: ScopedNavigatorState(navigatorKey: _navigatorKey)),
        InjectorProvider(),
        SetupStateProvider(),
        AuthStateProvider(),
        UserStateProvider(),
      ],
      child: MaterialApp(
        theme: AppTheme.defaultTheme,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: localizedLabels.keys,
        navigatorKey: _navigatorKey,
        onGenerateInitialRoutes: (name) => [RouteConfig.generateInitialRoute(AppRouting.routes, name)],
        onGenerateRoute: (settings) => RouteConfig.generateRoute(AppRouting.routes, settings),
        navigatorObservers: [RouteConfig.createNavigationObserver(AppRouting.routes)],
        initialRoute: AppRouting.initialRoute,
      ),
    );
  }
}
