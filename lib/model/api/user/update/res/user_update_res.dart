import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/model/user/user.dart';

part 'user_update_res.freezed.dart';

@freezed
class UserUpdateRes with _$UserUpdateRes {
  factory UserUpdateRes.ok({required User user}) = UserUpdateResOk;

  factory UserUpdateRes.error() = UserUpdateResError;

  factory UserUpdateRes.fromJson(Map<String, dynamic> json) {
    switch(json['result']) {
      case 'ok':
        return UserUpdateRes.ok(user: User.fromJson(json));
      case 'fail':
        return UserUpdateRes.error();
      default:
        throw UnimplementedError();
    }
  }
}
