import 'package:sapiency_app/common/widgets/input/use_field_state.dart';
import 'package:sapiency_app/model/influencer/social_media/influencer_social_media_type.dart';
import 'package:sapiency_app/screen/influencer/flow/influencer_flow_state.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';

class InfluencerMediaScreenState {
  final FieldState facebookFieldState;
  final FieldState twitterFieldState;
  final FieldState instagramFieldState;
  final FieldState youtubeFieldState;
  final FieldState otherMediaFieldState;
  final Function() onProceed;

  const InfluencerMediaScreenState({
    required this.facebookFieldState,
    required this.twitterFieldState,
    required this.youtubeFieldState,
    required this.instagramFieldState,
    required this.otherMediaFieldState,
    required this.onProceed,
  });
}

InfluencerMediaScreenState useInfluencerMediaScreenState({required Function() navigateToMetatags}) {
  final flowState = useProvided<InfluencerFlowState>();
  final influencer = flowState.influencer;

  final otherMediaFieldState =
      useFieldStateSimple(initialValue: influencer.socialMedia?[InfluencerSocialMediaType.other]);
  final youtubeFieldState =
      useFieldStateSimple(initialValue: influencer.socialMedia?[InfluencerSocialMediaType.youtube]);
  final instagramFieldState =
      useFieldStateSimple(initialValue: influencer.socialMedia?[InfluencerSocialMediaType.instagram]);
  final twitterFieldState =
      useFieldStateSimple(initialValue: influencer.socialMedia?[InfluencerSocialMediaType.twitter]);
  final facebookFieldState =
      useFieldStateSimple(initialValue: influencer.socialMedia?[InfluencerSocialMediaType.facebook]);

  final socialMedia = {
    InfluencerSocialMediaType.other: otherMediaFieldState.value,
    InfluencerSocialMediaType.youtube: youtubeFieldState.value,
    InfluencerSocialMediaType.instagram: instagramFieldState.value,
    InfluencerSocialMediaType.twitter: twitterFieldState.value,
    InfluencerSocialMediaType.facebook: facebookFieldState.value,
  };

  onProceed() {
    navigateToMetatags();
    flowState.onInfluencerUpdated(influencer.copyWith(socialMedia: socialMedia));
  }

  return InfluencerMediaScreenState(
    youtubeFieldState: youtubeFieldState,
    facebookFieldState: facebookFieldState,
    twitterFieldState: twitterFieldState,
    instagramFieldState: instagramFieldState,
    otherMediaFieldState: otherMediaFieldState,
    onProceed: onProceed,
  );
}
