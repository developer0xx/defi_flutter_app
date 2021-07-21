// TODO: add icon and other related data
class InfluencerSocialMediaType {
  final String key;

  const InfluencerSocialMediaType._({required this.key});

  factory InfluencerSocialMediaType.fromJson(String json) => all.firstWhere((it) => it.key == json);

  String toJson() => key;

  static const facebook = InfluencerSocialMediaType._(key: 'facebook');
  static const twitter = InfluencerSocialMediaType._(key: 'twitter');
  static const youtube = InfluencerSocialMediaType._(key: 'youtube');
  static const instagram = InfluencerSocialMediaType._(key: 'instagram');
  static const other = InfluencerSocialMediaType._(key: 'other');

  static const all = [facebook, twitter, youtube, other, instagram];
}
