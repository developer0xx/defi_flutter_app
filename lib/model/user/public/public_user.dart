import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/model/crowdsale/crowdsale.dart';
import 'package:sapiency_app/model/influencer/influencer.dart';

part 'public_user.freezed.dart';

part 'public_user.g.dart';

@freezed
class PublicUser with _$PublicUser {
  const PublicUser._();

  @JsonSerializable()
  factory PublicUser.normal({
    required String nickname,
    String? imageUrl,
    String? description,
  }) = PublicUserNormal;

  @JsonSerializable()
  factory PublicUser.influencer({
    required String nickname,
    String? imageUrl,
    String? description,
    required Influencer influencer,
  }) = PublicUserInfluencer;

  factory PublicUser.fromJson(Map<String, dynamic> json) =>
      json['influencer'] != null ? _$_$PublicUserInfluencerFromJson(json) : _$_$PublicUserNormalFromJson(json);

  Influencer? get influencerOrNull => map(normal: (_) => null, influencer: (it) => it.influencer);
  Crowdsale? get crowdsaleOrNull => influencerOrNull?.crowdsale;
}
