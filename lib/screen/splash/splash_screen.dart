import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapiency_app/app/state/auth/auth_state.dart';
import 'package:sapiency_app/app/state/setup/use_async_effect_after_setup.dart';
import 'package:sapiency_app/app/state/user/user_state.dart';
import 'package:sapiency_app/common/constants/app_heroes.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/di/injector.dart';
import 'package:sapiency_app/model/auth/auth_status.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/auth/welcome/welcome_screen.dart';
import 'package:sapiency_app/screen/main/main_screen.dart';
import 'package:sapiency_app/screen/splash/update_screen.dart';
import 'package:sapiency_app/service/api/client/api_client_service.dart';
import 'package:sapiency_app/service/device/device_service.dart';
import 'package:sapiency_app/service/version/version_service.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';

class SplashScreen extends HookWidget {
  static const route = '/splash';
  static final routeConfig = RouteConfig.material(() => SplashScreen());

  @override
  Widget build(BuildContext context) {
    final apiClientService = useInjected<ApiClientService>();
    final versionService = useInjected<VersionService>();
    final userState = useProvided<UserState>();
    final authState = useProvided<AuthState>();

    final navigator = useScopedNavigator();

    useAsyncEffectAfterSetup(
      () async {
        final shouldUpdate = await versionService.shouldUpdateApp();
        if (shouldUpdate)
          navigator.pushReplacementNamed(UpdateAppScreen.route);
        else {
          final status = await apiClientService.hasAuthToken() ? AuthStatus.authorized : AuthStatus.none;
          authState.status = status;
          if (status == AuthStatus.authorized) {
            if (await userState.refresh() != null) {
              navigator.pushReplacementNamed(MainScreen.route);
            } else {
              navigator.pushReplacementNamed(WelcomeScreen.route);
            }
          } else {
            navigator.pushReplacementNamed(WelcomeScreen.route);
          }
        }
      },
    );

    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: SvgPicture.asset(
            AppImages.splashBackground,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Align(
          alignment: Alignment(0, -0.2),
          child: Hero(
            tag: AppHeroes.splashLogo,
            child: SvgPicture.asset(
              AppImages.splashForeground,
            ),
          ),
        ),
      ],
    );
  }
}
