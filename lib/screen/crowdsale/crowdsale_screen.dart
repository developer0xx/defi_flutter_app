import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/screen/crowdsale/dialogs/contribute_bottom_sheet/crowdsale_contribute_bottom_sheet.dart';
import 'package:sapiency_app/screen/crowdsale/state/crowdsale_screen_args.dart';
import 'package:sapiency_app/screen/crowdsale/state/crowdsale_screen_state.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';

import 'view/crowdsale_screen_view.dart';

class CrowdsaleScreen extends HookWidget {
  static const route = '/crowdsale';
  static final routeConfig = RouteConfig.material(() => CrowdsaleScreen());

  @override
  Widget build(BuildContext context) {
    final args = context.routeArgs<CrowdsaleScreenArgs>();
    final scaffoldContainingKey = useMemoized(() => GlobalKey());

    final state = useCrowdsaleScreenState(
      user: args!.user,
      contribute: () => CrowdsaleContributeBottomSheet.show(
        scaffoldContainingKey.currentContext!,
        user: args.user,
      ),
    );
    return CrowdsaleScreenView(state: state, scaffoldContainingKey: scaffoldContainingKey);
  }
}
