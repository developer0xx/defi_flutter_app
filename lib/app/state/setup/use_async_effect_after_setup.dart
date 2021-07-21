import 'package:sapiency_app/app/state/setup/setup_state.dart';
import 'package:sapiency_app/util/hook/use_async_effect.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';

void useAsyncEffectAfterSetup(Future<void> Function() effect, [List<Object>? keys]) {
  final appInitializationState = useProvided<SetupState>();
  useAsyncEffect(() async {
    if (appInitializationState.isInitialized) await effect();
  }, [appInitializationState, ...?keys]);
}
