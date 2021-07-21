#set($camelcase_name = ${StringUtils.removeAndHump(${NAME})})
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tirtracker/util/navigation/route_config.dart';

import './state/${NAME}_state.dart';
import './state/use_${NAME}_state.dart';
import './view/${NAME}_view.dart';

class $camelcase_name extends HookWidget {
  static const route = '${route}';
  static final routeConfig = RouteConfig.material((_) => $camelcase_name());
  
  @override
  Widget build(BuildContext context) {
    final state = use${camelcase_name}State();
    return ${camelcase_name}View(state: state); 
  }
}
