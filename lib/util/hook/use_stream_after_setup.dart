import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/app/state/setup/setup_state.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';
import 'package:sapiency_app/util/hook/use_stream_data.dart';

AsyncSnapshot<T?> useStreamAfterSetup<T>(
  Stream<T> Function() streamProvider, {
  required T initialData,
  List<Object?> keys = const [],
}) {
  final appInitializationState = useProvided<SetupState>();
  return useStreamAndLogErrors<T?>(
    useMemoized(() {
      if (appInitializationState.isInitialized)
        return streamProvider();
      else
        return Stream.empty();
    }, [appInitializationState.isInitialized, ...keys]),
    initialData: initialData,
  );
}
