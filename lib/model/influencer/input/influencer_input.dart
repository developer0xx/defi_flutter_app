import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/model/influencer/social_media/influencer_social_media_map_converter.dart';
import 'package:sapiency_app/model/influencer/social_media/influencer_social_media_type.dart';
import 'package:sapiency_app/util/converter/date_time_date_converter.dart';

part 'influencer_input.freezed.dart';

part 'influencer_input.g.dart';

// simplification: nullable fields to allow builder-like usage
@freezed
class InfluencerInput with _$InfluencerInput {
  const InfluencerInput._();

  factory InfluencerInput({
    String? firstName,
    String? lastName,
    @NullableDateTimeDateConverter() DateTime? dateOfBirth,
    @NullableInfluencerSocialMediaMapConverter() Map<InfluencerSocialMediaType, String>? socialMedia,
    List<String>? metaTags,
    String? token,
    String? tokenName,
  }) = _InfluencerInput;

  factory InfluencerInput.fromJson(Map<String, dynamic> json) => _$InfluencerInputFromJson(json);

  List<Object?> get fields => [firstName, lastName, dateOfBirth, socialMedia, metaTags, token, tokenName];
  bool get isComplete => fields.every((it) => it != null);
}
