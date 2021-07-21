class WalletSendSuccessScreenState {
  final Function() onProceed;

  const WalletSendSuccessScreenState({
    required this.onProceed,
  });
}

WalletSendSuccessScreenState useWalletSendSuccessScreenState({required Function() navigateBack}) {
  return WalletSendSuccessScreenState(
    onProceed: navigateBack,
  );
}
