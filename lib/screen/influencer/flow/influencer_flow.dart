import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:sapiency_app/navigator/scoped_navigator_state.dart';
import 'package:sapiency_app/navigator/use_scoped_navigator.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';
import 'package:sapiency_app/util/widget/navigator/nested_navigator.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

import 'influencer_flow_args.dart';
import 'influencer_flow_routing.dart';
import 'influencer_flow_state.dart';

class InfluencerFlow extends HookWidget {
  static const route = '/flow/influencer';
  static final routeConfig = RouteConfig.material(
    () => InfluencerFlow(),
    orientation: RouteConfigOrientation.portrait,
  );
  static const int stepQuantity = 8;

  @override
  Widget build(BuildContext context) {
    final args = context.routeArgs<InfluencerFlowArgs>();
    final parentNavigator = useScopedNavigator();
    final navigatorKey = useMemoized(() => GlobalKey<NavigatorState>());
    final state = useInfluencerFlowState(args: args!);

    return MultiProvider(
      providers: [
        Provider<InfluencerFlowState>.value(value: state),
        Provider<ScopedNavigatorState>.value(value: ScopedNavigatorState(navigatorKey: navigatorKey)),
      ],
      child: NestedNavigator(
        navigatorKey: navigatorKey,
        parentNavigator: parentNavigator,
        routes: InfluencerFlowRouting.routes,
        initialRoute: InfluencerFlowRouting.initialRoute,
      ),
    );
  }
}
