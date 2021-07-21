import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/app/state/setup/setup_state.dart';
import 'package:sapiency_app/util/hook/hook_state_provider_widget.dart';
import 'package:sapiency_app/util/hook/use_async_effect.dart';

class SetupStateProvider extends HookStateProviderWidget<SetupState> {
  @override
  SetupState use() {
    final isInitializedValue = useState<bool>(false);

    Future<void> load() async {
      await Firebase.initializeApp();
    }

    useAsyncEffect(() async {
      await Future.wait([
        load(),
        Future.delayed(Duration(seconds: 1)), // workaround: ensure long enough wait to prevent startup lag
      ]);
      isInitializedValue.value = true;
    }, []);

    return SetupState(isInitialized: isInitializedValue.value);
  }

  void setupCrashlytics() async {
    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    }
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await FirebaseCrashlytics.instance.recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
      );
    }).sendPort);
  }
}
