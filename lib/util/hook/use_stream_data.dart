import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/logger.dart';

AsyncSnapshot<T> useStreamAndLogErrors<T>(Stream<T> stream, {required T initialData}) {
  return useStream(
    useMemoized(() async* {
      try {
        await for(final value in stream) yield value;
      } catch (e, s) {
        logError('Error in useStream', e, s);
        throw e;
      }
    }, [stream]),
    initialData: initialData,
  );
}
