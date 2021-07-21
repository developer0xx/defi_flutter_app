import 'package:freezed_annotation/freezed_annotation.dart';

enum UserLoginType {
  @JsonValue('EMAIL') email,
  @JsonValue('DEVICE_PIN') devicePin,
}