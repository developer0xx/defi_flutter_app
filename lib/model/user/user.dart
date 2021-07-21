import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/model/crowdsale/crowdsale.dart';
import 'package:sapiency_app/model/influencer/influencer.dart';
import 'package:sapiency_app/model/user/public/public_user.dart';
import 'package:sapiency_app/model/user/wallets/user_wallets.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  const User._();

  factory User({
    required String email,
    required String phone,
    required UserWallets wallets,
    required List<String> consents,
    required PublicUser public,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Influencer? get influencerOrNull => public.influencerOrNull;
  Crowdsale? get crowdsaleOrNull => public.crowdsaleOrNull;
}
