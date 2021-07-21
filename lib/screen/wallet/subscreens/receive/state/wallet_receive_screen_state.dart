import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:sapiency_app/app/state/user/user_state.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';
import 'package:sapiency_app/common/widgets/snackbar/snackbars.dart';
import 'package:sapiency_app/service/wallet/wallet_service.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';
import 'package:share/share.dart';

class WalletReceiveScreenState {
  final FieldState addressState;
  final Function(BuildContext) onCopyPressed;
  final Function() onSharePressed;

  const WalletReceiveScreenState({
    required this.addressState,
    required this.onCopyPressed,
    required this.onSharePressed,
  });
}

WalletReceiveScreenState useWalletReceiveScreenState({
  required Function(BuildContext, String) copyAddress,
  required Function(String) shareAddress,
}) {
  final userState = useProvided<UserState>();

  final address = WalletService.encodeNickname(userState.user!.public.nickname);
  final addressState = useFieldStateSimple(initialValue: address);

  return WalletReceiveScreenState(
    addressState: addressState,
    onCopyPressed: (context) => copyAddress(context, address),
    onSharePressed: () => shareAddress(address),
  );
}
