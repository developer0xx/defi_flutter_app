import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sapiency_app/common/widgets/submit/submit_wrapper.dart';
import 'package:sapiency_app/screen/wallet/subscreens/send/state/use_wallet_send_screen_state.dart';
import 'package:sapiency_app/screen/wallet/subscreens/send/widget/wallet_send_content.dart';
import 'package:sapiency_app/screen/wallet/subscreens/send/widget/wallet_send_screen_info.dart';

class WalletSendScreenView extends StatelessWidget {
  final WalletSendScreenState state;

  const WalletSendScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SubmitWrapper(
        state: state.submitState,
        child: Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WalletSendScreenInfo(state: state),
              Expanded(child: WalletSendScreenContent(state: state)),
            ],
          ),
        ),
      ),
    );
  }
}
