import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_input.freezed.dart';

part 'user_input.g.dart';

@freezed
class UserInput with _$UserInput {
  factory UserInput({
    required String nickname,
    String? imageUrl,
    String? description,
  }) = _UserInput;

  factory UserInput.fromJson(Map<String, dynamic> json) => _$UserInputFromJson(json);
}
