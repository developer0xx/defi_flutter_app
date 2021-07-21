import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/model/user/user.dart';

part 'get_user_res.freezed.dart';

@freezed
class GetUserRes with _$GetUserRes {
  factory GetUserRes.ok({required User user}) = GetUserResOk;

  factory GetUserRes.error() = GetUserResError;

  factory GetUserRes.fromJson(Map<String, dynamic> json) {
    switch (json['result']) {
      case 'ok':
        // note: 'embedded' json deserialization
        return GetUserRes.ok(user: User.fromJson(json));
      case 'fail':
        return GetUserRes.error();
      default:
        throw UnimplementedError();
    }
  }
}
