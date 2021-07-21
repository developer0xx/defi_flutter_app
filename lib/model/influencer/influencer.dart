import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/model/crowdsale/crowdsale.dart';
import 'package:sapiency_app/model/influencer/social_media/influencer_social_media_map_converter.dart';
import 'package:sapiency_app/model/influencer/social_media/influencer_social_media_type.dart';
import 'package:sapiency_app/util/converter/date_time_date_converter.dart';

part 'influencer.freezed.dart';

part 'influencer.g.dart';

@freezed
class Influencer with _$Influencer {
  const Influencer._();

  factory Influencer({
    required String firstName,
    required String lastName,
    @DateTimeDateConverter() required DateTime dateOfBirth,
    @InfluencerSocialMediaMapConverter() required Map<InfluencerSocialMediaType, String> socialMedia,
    required List<String> metaTags,
    required String token,
    required String tokenName,
    required bool approved,
    Crowdsale? crowdsale,
  }) = _Influencer;

  factory Influencer.fromJson(Map<String, dynamic> json) => _$InfluencerFromJson(json);

  String get fullName => firstName + ' ' + lastName;
}
