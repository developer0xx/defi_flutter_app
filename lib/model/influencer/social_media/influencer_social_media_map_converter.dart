import 'package:json_annotation/json_annotation.dart';
import 'package:sapiency_app/model/influencer/social_media/influencer_social_media_type.dart';

class InfluencerSocialMediaMapConverter
    implements JsonConverter<Map<InfluencerSocialMediaType, String>, Map<String, dynamic>> {
  const InfluencerSocialMediaMapConverter();

  @override
  Map<InfluencerSocialMediaType, String> fromJson(Map<String, dynamic> json) =>
      json.map((key, value) => MapEntry(InfluencerSocialMediaType.fromJson(key), value));

  @override
  Map<String, String> toJson(Map<InfluencerSocialMediaType, String> object) =>
      object.map((key, value) => MapEntry(key.toJson(), value));
}

class NullableInfluencerSocialMediaMapConverter
    implements JsonConverter<Map<InfluencerSocialMediaType, String>?, Map<String, dynamic>?> {
  const NullableInfluencerSocialMediaMapConverter();

  @override
  Map<InfluencerSocialMediaType, String>? fromJson(Map<String, dynamic>? json) =>
      json?.map((key, value) => MapEntry(InfluencerSocialMediaType.fromJson(key), value));

  @override
  Map<String, String>? toJson(Map<InfluencerSocialMediaType, String>? object) =>
      object?.map((key, value) => MapEntry(key.toJson(), value));
}
