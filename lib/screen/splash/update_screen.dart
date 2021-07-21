import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapiency_app/common/constants/app_heroes.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/widgets/button/button.dart';
import 'package:sapiency_app/config/config.dart';
import 'package:sapiency_app/service/version/version_service.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class UpdateAppScreen extends HookWidget {
  static const route = '/splash/update';
  static final routeConfig = RouteConfig.material(() => UpdateAppScreen());

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: AppHeroes.splashLogo,
                child: SvgPicture.asset(
                  AppImages.splashForeground,
                ),
              ),
              _buildButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    //TODO: add handling ios
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Button(
          text: context.strings.updateVersion.button,
          onPressed: () => launch(Config.googlePlayUrl),
        ),
      ),
    );
  }
}
