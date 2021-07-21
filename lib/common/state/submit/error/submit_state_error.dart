import 'package:freezed_annotation/freezed_annotation.dart';

part 'submit_state_error.freezed.dart';

@freezed
abstract class SubmitStateError<E> with _$SubmitStateError<E> {
  factory SubmitStateError.known(E value) = SubmitStateErrorKnown<E>;

  factory SubmitStateError.unknown() = SubmitStateErrorUnknown<E>;
}
