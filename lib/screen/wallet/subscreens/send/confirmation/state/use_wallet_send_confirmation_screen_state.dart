import 'package:sapiency_app/app/state/user/user_state.dart';
import 'package:sapiency_app/common/state/submit/use_submit_state.dart';
import 'package:sapiency_app/di/injector.dart';
import 'package:sapiency_app/screen/wallet/subscreens/send/confirmation/state/wallet_send_confirmation_screen_args.dart';
import 'package:sapiency_app/service/wallet/wallet_service.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';
import 'package:sapiency_app/util/hook/use_togglable_bool.dart';

class WalletSendConfirmationScreenState {
  final TogglableBoolState switchState;
  final WalletSendConfirmationScreenArgs args;
  final SubmitState submitState;

  const WalletSendConfirmationScreenState({
    required this.switchState,
    required this.args,
    required this.submitState,
  });
}

WalletSendConfirmationScreenState useWalletSendConfirmationScreenState({
  required WalletSendConfirmationScreenArgs args,
  required Function() navigateToSuccess,
}) {
  final walletService = useInjected<WalletService>();
  final userState = useProvided<UserState>();

  final switchState = useTogglableBool(false);
  final submitState = useSubmitStateSimple(performSubmit: () async {
    await walletService.send(
      token: args.tokenSymbol,
      amount: args.amount,
      nicknameOrEmailOrAddress: args.recipient,
    );
  }, afterSubmit: (_) {
    //do not await so navigation always happens
    userState.refresh();
    navigateToSuccess();
  });

  return WalletSendConfirmationScreenState(
    args: args,
    submitState: submitState,
    switchState: switchState,
  );
}
