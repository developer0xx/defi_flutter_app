import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/logger.dart';
import 'package:sapiency_app/util/extension/value_notifier_extensions.dart';
import 'package:sapiency_app/util/hook/use_async_effect.dart';

class AsyncComputedState<T> {
  final T? value;
  final bool isInProgress;
  final Future<T?> Function() refresh;
  final Function(T value) setValue;

  const AsyncComputedState({
    required this.value,
    required this.isInProgress,
    required this.refresh,
    required this.setValue,
  });

  set value(value) => setValue(value);
}

AsyncComputedState<T> useAsyncComputedState<T>({
  required Future<T> Function() compute,
  bool Function()? shouldCompute,
  List<Object?> keys = const [],
}) {
  final state = useState<T?>(null);
  final isInProgress = useState<bool>(false);

  Future<T?> performCompute() async {
    isInProgress.value = true;
    try {
      final value = await compute();
      state.value = value;
      isInProgress.value = false;
      return value;
    } catch (e, s) {
      logger.w('error during performCompute', e, s);
      isInProgress.value = false;
    }
  }

  Future<T?> performComputeOrWait() async {
    if (isInProgress.value) {
      await isInProgress.awaitSingle();
      return state.value as T;
    } else {
      return await performCompute();
    }
  }

  useAsyncEffect(() async {
    if (shouldCompute == null || shouldCompute()) await performComputeOrWait();
  }, keys);

  return AsyncComputedState(
    value: state.value,
    isInProgress: isInProgress.value,
    refresh: performComputeOrWait,
    setValue: (value) => state.value = value,
  );
}
