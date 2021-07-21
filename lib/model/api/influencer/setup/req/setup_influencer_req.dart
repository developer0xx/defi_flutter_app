import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sapiency_app/model/crowdsale/input/crowdsale_input.dart';
import 'package:sapiency_app/model/influencer/input/influencer_input.dart';

part 'setup_influencer_req.freezed.dart';

part 'setup_influencer_req.g.dart';

@freezed
class SetupInfluencerReq with _$SetupInfluencerReq {
  factory SetupInfluencerReq({
    required InfluencerInput influencer,
    required CrowdsaleInput? crowdsale,
  }) = _SetupInfluencerReq;

  factory SetupInfluencerReq.fromJson(Map<String, dynamic> json) => _$SetupInfluencerReqFromJson(json);
}
