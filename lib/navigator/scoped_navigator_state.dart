import 'package:flutter/cupertino.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'scoped_navigator_state.freezed.dart';

@freezed
class ScopedNavigatorState with _$ScopedNavigatorState {
  factory ScopedNavigatorState({required GlobalKey<NavigatorState> navigatorKey}) = _ScopedNavigatorState;
}
