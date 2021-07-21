import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/screen/wallet/state/wallet_page_state.dart';
import 'package:sapiency_app/screen/wallet/widgets/wallet_icon.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class WalletOptionRow extends StatelessWidget {
  final WalletPageState state;

  const WalletOptionRow({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        WalletIcon(iconPath: AppImages.sendIcon, title: context.strings.wallet.option.send),
        WalletIcon(
          iconPath: AppImages.receiveIcon,
          title: context.strings.wallet.option.receive,
          onPressed: state.onReceivePressed,
        ),
        WalletIcon(iconPath: AppImages.sellIcon, title: context.strings.wallet.option.sell),
        WalletIcon(iconPath: AppImages.depositIcon, title: context.strings.wallet.option.deposit),
      ],
    );
  }
}
