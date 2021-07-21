import 'dart:async';

import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../logger.dart';
import 'error/submit_state_error.dart';

class SubmitState<E> {
  final bool isSubmitInProgress;
  final Function() onSubmitPressed;
  final Stream<E> errorStream;
  final Stream<Null> unknownErrorStream;

  SubmitState({
    required this.isSubmitInProgress,
    required this.onSubmitPressed,
    required this.errorStream,
    required this.unknownErrorStream,
  });
}

SubmitState<void> useSubmitStateSimple<T>({
  FutureOr<bool> Function()? shouldSubmit,
  required Future<T> Function() performSubmit,
  FutureOr<void> Function(T)? afterSubmit,
  Function(Object)? afterError,
}) =>
    useSubmitState<T, Null, Object>(
      shouldSubmit: shouldSubmit,
      performSubmit: performSubmit,
      mapError: (_) => SubmitStateError.unknown(),
      afterSubmit: afterSubmit,
      afterError: (_, ex) => afterError?.call(ex),
    );

SubmitState<E> useSubmitState<T, E, EX extends Object>({
  required Future<T> Function() performSubmit,
  required SubmitStateError<E> Function(EX) mapError,
  FutureOr<bool> Function()? shouldSubmit,
  FutureOr<void> Function(T)? afterSubmit,
  Function(SubmitStateError<E>, EX)? afterError,
  Function(Function())? showConfirmDialog,
}) {
  final isSubmitInProgressState = useState<bool>(false);
  final errorController = useStreamController<E>(); // ignore: close_sinks
  final unknownErrorController = useStreamController<Null>(); // ignore: close_sinks

  void trySubmit() async {
    try {
      isSubmitInProgressState.value = true;
      if (shouldSubmit != null && !await shouldSubmit()) {
        isSubmitInProgressState.value = false;
        return;
      }
      final result = await performSubmit();
      try {
        await afterSubmit?.call(result);
      } finally {
        isSubmitInProgressState.value = false;
      }
    } on EX catch (exception, stack) {
      logger.w("error in SubmitState", exception, stack);
      isSubmitInProgressState.value = false;
      final error = mapError(exception);
      error.when(
        unknown: () => unknownErrorController.add(null),
        known: (error) => errorController.add(error),
      );
      afterError?.call(error, exception);
    }
  }

  showDialog() async {
    await showConfirmDialog!(() => trySubmit());
  }

  return SubmitState(
    isSubmitInProgress: isSubmitInProgressState.value,
    onSubmitPressed: () => (showConfirmDialog != null) ? showDialog() : trySubmit(),
    errorStream: errorController.stream,
    unknownErrorStream: unknownErrorController.stream,
  );
}
