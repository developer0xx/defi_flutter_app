import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:sapiency_app/app/state/user/user_state.dart';
import 'package:sapiency_app/common/state/submit/use_submit_state.dart';
import 'package:sapiency_app/common/widgets/input/input_validator.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';
import 'package:sapiency_app/di/injector.dart';
import 'package:sapiency_app/model/user/wallet/user_wallet.dart';
import 'package:sapiency_app/screen/wallet/subscreens/send/confirmation/state/wallet_send_confirmation_screen_args.dart';
import 'package:sapiency_app/service/user/user_service.dart';
import 'package:sapiency_app/util/extension/extensions.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';

class WalletSendScreenState {
  final UserWallet wallet;
  final FieldState recipientState;
  final FieldState noteState;
  final FieldState amountState;
  final bool buttonEnabled;
  final SubmitState submitState;
  final Function() onMaxPressed;
  final Future<String?> Function() onScannedPressed;

  const WalletSendScreenState({
    required this.wallet,
    required this.buttonEnabled,
    required this.amountState,
    required this.noteState,
    required this.recipientState,
    required this.submitState,
    required this.onMaxPressed,
    required this.onScannedPressed,
  });
}

WalletSendScreenState useWalletSendScreenState({
  required UserWallet wallet,
  required Function(WalletSendConfirmationScreenArgs) navigateToConfirmation,
  required Function() navigateToScanner,
}) {
  final userService = useInjected<UserService>();
  final userState = useProvided<UserState>();
  final user = userState.user;

  final recipientState = useFieldStateSimple();
  final amountState = useFieldStateSimple();
  final noteState = useFieldStateSimple();

  Future<String Function(BuildContext)?> validateRecipient(String email) async {
    final doesUserExist = await userService.doesUserExist(nicknameOrEmail: recipientState.value);
    if (!doesUserExist) return (BuildContext context) => context.strings.wallet.send.error.noUserFound;
    return null;
  }

  String Function(BuildContext)? validateTargetIsThisUser() {
    if (user!.public.nickname == recipientState.value || user.email == recipientState.value)
      return (context) => context.strings.wallet.send.error.userIsIdiot;
    else
      return null;
  }

  Future<bool> validate() async {
    final amountError = amountState.validate((value) => InputValidator.validateTokenAmount(value, wallet.value.amount));
    final noUserFoundError = await recipientState.validateAsync((value) async => await validateRecipient(value));
    final targetIsThisUserError = recipientState.validate((value) => validateTargetIsThisUser());

    return amountError == null && noUserFoundError == null && targetIsThisUserError == null;
  }

  submit() async {
    navigateToConfirmation(
      WalletSendConfirmationScreenArgs(
        recipient: recipientState.value,
        amount: Decimal.parse(amountState.value),
        notes: noteState.value,
        tokenSymbol: wallet.value.symbol,
      ),
    );
  }

  final submitState = useSubmitStateSimple(performSubmit: submit, shouldSubmit: () async => await validate());

  final buttonEnabled = recipientState.isNotEmpty &&
      amountState.isNotEmpty &&
      amountState.value.doesParseToDecimal() &&
      Decimal.parse(amountState.value) > Decimal.zero;

  return WalletSendScreenState(
    wallet: wallet,
    amountState: amountState,
    noteState: noteState,
    recipientState: recipientState,
    buttonEnabled: buttonEnabled,
    submitState: submitState,
    onMaxPressed: () => amountState.value = wallet.value.amount.toString(),
    onScannedPressed: () async {
      final result = await navigateToScanner();
      if (result != null) recipientState.value = result;
    },
  );
}
