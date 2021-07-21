import 'package:flutter/cupertino.dart';
import 'package:sapiency_app/navigator/scoped_navigator_state.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';

NavigatorState useScopedNavigator() => useProvided<ScopedNavigatorState>().navigatorKey.currentState!;
