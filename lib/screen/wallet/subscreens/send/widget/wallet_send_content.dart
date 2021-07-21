import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/common/widgets/button/button.dart';
import 'package:sapiency_app/common/widgets/input/app_text_input.dart';
import 'package:sapiency_app/screen/wallet/subscreens/send/state/use_wallet_send_screen_state.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class WalletSendScreenContent extends StatelessWidget {
  final WalletSendScreenState state;

  const WalletSendScreenContent({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppValues.screenPadding,
      physics: BouncingScrollPhysics(),
      children: [
        _buildFields(context),
        _buildButton(context),
      ],
    );
  }

  Widget _buildFields(BuildContext context) {
    return Column(
      children: [
        AppTextInput(
          state: state.recipientState,
          label: context.strings.wallet.send.label.recipient,
          hintText: context.strings.wallet.send.hint.recipient,
          textInputAction: TextInputAction.next,
          onSubmitFocusChanged: state.amountState.requestFocus,
          customSuffix: InkWell(
            onTap: () => state.onScannedPressed(),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: SvgPicture.asset(AppImages.scanIcon),
            ),
          ),
        ),
        AppTextInput(
          state: state.amountState,
          label: context.strings.crowdsale.sheet.label.price,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          onSubmitFocusChanged: state.noteState.requestFocus,
          suffixText: state.wallet.value.symbol,
          linkText: 'MAX',
          onLinkPressed: () => state.onMaxPressed(),
        ),
        AppTextInput(
          state: state.noteState,
          label: context.strings.wallet.send.label.note,
          hintText: context.strings.wallet.send.hint.note,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          maxLines: 7,
          minLines: 3,
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Button(
        text: context.strings.wallet.send.button,
        enabled: state.buttonEnabled,
        onPressed: state.submitState.onSubmitPressed,
      ),
    );
  }
}
