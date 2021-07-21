import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/model/user/input/user_input.dart';

part 'user_update_req.freezed.dart';

part 'user_update_req.g.dart';

@freezed
class UserUpdateReq with _$UserUpdateReq {
  factory UserUpdateReq({required UserInput user}) = _UserUpdateReq;

  factory UserUpdateReq.fromJson(Map<String, dynamic> json) => _$UserUpdateReqFromJson(json);
}
