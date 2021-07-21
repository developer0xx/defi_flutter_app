import 'package:sapiency_app/logger.dart';
import 'package:sapiency_app/util/hook/use_simple_effect.dart';

void useAsyncEffect(Future<void> Function() effect, [List<Object?>? keys]) {
  useSimpleEffect(
    () {
      try {
        Future.microtask(() => effect());
      } catch (e, s) {
        logError('Error in useAsyncEffect', e, s);
      }
    },
    keys,
  );
}
