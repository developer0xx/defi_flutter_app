import 'package:freezed_annotation/freezed_annotation.dart';

part 'setup_state.freezed.dart';

@freezed
class SetupState with _$SetupState {
  factory SetupState({required bool isInitialized}) = _SetupState;
}
