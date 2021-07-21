import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/model/influencer/influencer.dart';

part 'setup_influencer_res.freezed.dart';

@freezed
class SetupInfluencerRes with _$SetupInfluencerRes {
  factory SetupInfluencerRes.ok({required Influencer influencer}) = SetupInfluencerResOk;

  factory SetupInfluencerRes.error() = SetupInfluencerResError;

  factory SetupInfluencerRes.fromJson(Map<String, dynamic> json) {
    switch(json['result']) {
      case 'ok':
        // note: 'embedded' json deserialization
        return SetupInfluencerRes.ok(influencer: Influencer.fromJson(json));
      case 'fail':
        return SetupInfluencerRes.error();
      default:
        throw UnimplementedError();
    }
  }
}
