class InfluencerIntroScreenState {
  final Function() onProceed;

  const InfluencerIntroScreenState({
    required this.onProceed,
  });
}

InfluencerIntroScreenState useInfluencerIntroScreenState(Function() navigateToStepTwo) {
  return InfluencerIntroScreenState(
    onProceed: navigateToStepTwo,
  );
}
