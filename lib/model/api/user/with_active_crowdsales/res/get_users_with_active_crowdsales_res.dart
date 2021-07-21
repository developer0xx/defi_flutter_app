import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/model/user/public/public_user.dart';

part 'get_users_with_active_crowdsales_res.freezed.dart';

part 'get_users_with_active_crowdsales_res.g.dart';

@Freezed(unionKey: 'result')
class GetUsersWithActiveCrowdsalesRes with _$GetUsersWithActiveCrowdsalesRes {
  @FreezedUnionValue('ok')
  factory GetUsersWithActiveCrowdsalesRes.ok({
    required List<PublicUserInfluencer> users,
  }) = GetUsersWithActiveCrowdsalesResOk;

  @FreezedUnionValue('fail')
  factory GetUsersWithActiveCrowdsalesRes.error() = GetUsersWithActiveCrowdsalesResError;

  factory GetUsersWithActiveCrowdsalesRes.fromJson(Map<String, dynamic> json) =>
      _$GetUsersWithActiveCrowdsalesResFromJson(json);
}
