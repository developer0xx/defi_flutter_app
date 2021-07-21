import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/screen/influencer/flow/influencer_flow.dart';
import 'package:sapiency_app/screen/influencer/flow/influencer_flow_args.dart';
import 'package:sapiency_app/screen/main/state/use_main_screen_state.dart';
import 'package:sapiency_app/screen/main/view/main_screen_view.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';

class MainScreen extends HookWidget {
  static const route = '/main';
  static final routeConfig = RouteConfig.material(() => MainScreen());

  @override
  Widget build(BuildContext context) {
    final state = useMainScreenState();
    return MainScreenView(state: state);
  }
}
